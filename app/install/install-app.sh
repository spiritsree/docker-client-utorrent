#!/bin/bash

DOCKERIZE_VERSION='0.6.1'

DOCKERIZE_IMAGE_URL="https://github.com/jwilder/dockerize/releases/download/v${DOCKERIZE_VERSION}/dockerize-linux-amd64-v${DOCKERIZE_VERSION}.tar.gz"
UTSERVER_URL="http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-ubuntu-13-04"
NG_UI="https://github.com/psychowood/ng-torrent-ui/releases/latest/download/webui.zip"
TMP_DIR="/opt/setup-dir"

mkdir -p /utorrent/webui/{default,ng}
mkdir -p "${TMP_DIR}"
pushd "${TMP_DIR}" > /dev/null || exit 1

# Installing dockerize
echo "**** install dockerize ****"
curl -sL "${DOCKERIZE_IMAGE_URL}" 2> /dev/null | tar -C /usr/local/bin -xz

# Installing uTorrent
echo "**** install utorrent ****"
curl -sSL "${UTSERVER_URL}" -o utserver.tar.gz
tar xvf utserver.tar.gz --strip 1 -C /utorrent
mv /utorrent/webui.zip /utorrent/webui/default/

echo "**** install custom UI ****"
curl -sSL "${NG_UI}" -o /utorrent/webui/ng/webui.zip

popd > /dev/null || exit 1
rm -rf "${TMP_DIR}"
