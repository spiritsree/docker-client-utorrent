# shellcheck shell=bash

# Create dir if not exist and update permission
# Syntax: _create_dir_perm <dir> <uid>
_create_dir_perm() {
    local dir_path=$1
    local user_id=$2

    if [[ ! -d "${dir_path}" ]]; then
        mkdir -p "${dir_path}"
    fi

    echo "[UTORRENT] Changing ownership of dir ${dir_path} to ${user_id}..."
    if (getent group "${user_id}" > /dev/null 2>&1) &&
        (getent passwd "${user_id}" > /dev/null 2>&1); then
        chown -R "${user_id}:${user_id}" "${dir_path}"
        chmod -R 775 "${dir_path}"
    else
        echo "[UTORRENT] User/Group ${user_id} does not exist. Please run it as root..."
        exit 1
    fi
}

# export a prefix_key=value based on input (e.g: _export_env_var prefix key val)
_export_env_var() {
    local prefix=$1
    local key=$2; shift; shift
    local value="${*}"
    local sane_value="${value// /}"
    local env_key

    env_key=$(echo "${prefix}_${key}" | tr '-' '_' | tr '[:lower:]' '[:upper:]')
    if [[ -z "$(printf '%s' "${!env_key}")" ]]; then
        eval "export ${env_key}=${sane_value}"
    fi
}

# Populate env vars from config file if env does not exist
_get_settings() {
    local prefix=$1
    local settings_file=$2
    local setting s_key s_value

    while read -r setting; do
        s_key=$(echo "${setting}" | tr -d ' ' | awk -F':' '{ print $1 }')
        s_value=$(echo "${setting}" | tr -d ' ' | awk -F':' '{ print $2 }')
        _export_env_var "${prefix}" "${s_key}" "${s_value}"
    done < "${settings_file}"
}
