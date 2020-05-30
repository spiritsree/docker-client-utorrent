#!/bin/bash

# shellcheck source=../scripts/functions.sh
# shellcheck disable=SC1091
source /usr/local/scripts/functions.sh

if [[ "${ENABLE_FILE_LOGGING}" == "false" ]]; then
    export LOG_FILE="/proc/self/fd/1"
else
    touch "${LOG_FILE}"
    chmod 666 "${LOG_FILE}"
fi

if [[ ! -d "${UTORRENT_HOME}" ]]; then
    mkdir -p "${UTORRENT_HOME}"
fi

# Create a non privileged user if not root
if [[ "${UTORRENT_RUNAS_ROOT,,}" == "false" ]]; then
    export UTORRENT_USER='utorrent'
else
    export UTORRENT_USER='root'
fi
UTORRENT_UID=$(id -u "${UTORRENT_USER}")
UTORRENT_GID=$(id -g "${UTORRENT_USER}")
export UTORRENT_UID
export UTORRENT_GID

# Create the directories if not
echo "[UTORRENT] Setting up various directory permissions..." >> ${LOG_FILE}
{
    _create_dir_perm "/utorrent" "${UTORRENT_USER}";
    _create_dir_perm "${UTORRENT_HOME}" "${UTORRENT_USER}";
    _create_dir_perm "${UTORRENT_HOME}/torrents" "${UTORRENT_USER}";
    _create_dir_perm "${UTORRENT_HOME}/temp" "${UTORRENT_USER}";
    _create_dir_perm "${UTORRENT_HOME}/settings" "${UTORRENT_USER}";
    _create_dir_perm "${UTORRENT_WATCH_DIR}" "${UTORRENT_USER}";
    _create_dir_perm "${UTORRENT_INCOMPLETE_DIR}" "${UTORRENT_USER}";
    _create_dir_perm "${UTORRENT_DOWNLOAD_DIR}" "${UTORRENT_USER}";
} >> ${LOG_FILE}

if [[ -f "${UTORRENT_HOME}/utserver.conf" ]] && [[ "${UTORRENT_SETTING_DEFAULT,,}" == "false" ]]; then
    echo "[UTORRENT] uTorrent will preserve the config..." >> ${LOG_FILE}
    _get_settings "utorrent" "${UTORRENT_HOME}/utserver.conf"
else
    # Move old settings file
    echo "[UTORRENT] Moving the old settings file..." >> ${LOG_FILE}
    mv "${UTORRENT_HOME}/settings/settings.dat" "${UTORRENT_HOME}/settings/settings.dat.old"
    echo "[UTORRENT] uTorrent will use default config..." >> ${LOG_FILE}
    dockerize -template "/etc/config/utserver.conf.tmpl:/tmp/utserver.conf"
    _get_settings "utorrent" "/tmp/utserver.conf"
fi

# uTorrent custom UI
if [[ "${UTORRENT_WEB_UI,,}" == "ng" ]]; then
    echo "[UTORRENT] Using NG as the Web UI" >> ${LOG_FILE}
    export UTORRENT_WEB_UI="ng"
    export UTORRENT_WEB_HOME="/utorrent/webui/ng"
else
    echo "[UTORRENT] Using the built-in Web UI" >> ${LOG_FILE}
    export UTORRENT_WEB_UI="default"
    export UTORRENT_WEB_HOME="/utorrent/webui/default"
fi

dockerize -template "/etc/config/utserver.conf.tmpl:${UTORRENT_HOME}/utserver.conf"

if [[ "${UTORRENT_START_DELAY-}" =~ ^[0-9]+$ ]]; then
    echo "[UTORRENT] Delaying the startup by ${UTORRENT_START_DELAY}..." >> ${LOG_FILE}
    sleep "${UTORRENT_START_DELAY}"
fi

echo "[UTORRENT] uTorrent will run as \"${UTORRENT_USER}\" with UID \"${UTORRENT_UID}\" and GID \"${UTORRENT_GID}\"" >> ${LOG_FILE}
exec su -p "${UTORRENT_USER}" -s /bin/bash -c "/utorrent/utserver -settingspath ${UTORRENT_HOME}/settings -configfile ${UTORRENT_HOME}/utserver.conf -logfile ${LOG_FILE}"

