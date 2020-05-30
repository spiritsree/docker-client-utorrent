FROM ubuntu:18.04

# Enable the non-interactive mode while installing apps
ARG DEBIAN_FRONTEND=noninteractive

ADD ./app/install /scripts

RUN apt-get update > /dev/null \
    && apt-get -y install --no-install-recommends apt-utils software-properties-common > /dev/null 2>&1 \
    && echo "**** install packages ****" \
    && apt-get -y upgrade > /dev/null \
    && apt-get -y install --no-install-recommends curl iputils-ping libssl1.0.0 > /dev/null \
    && apt-get -y install --no-install-recommends dumb-init > /dev/null \
    && bash /scripts/install-app.sh \
    && echo "**** cleanup ****" \
    && apt-get -y remove curl > /dev/null \
    && apt-get -y autoremove > /dev/null \
    && apt-get -y clean > /dev/null \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd -u 1999 -U -s $(which nologin) utorrent

ADD ./app/config /etc/config
ADD ./app/scripts /usr/local/scripts

ENV HEALTH_CHECK_HOST=www.google.com \
    ENABLE_FILE_LOGGING=true \
    LOG_FILE=/data/application.log \
    UTORRENT_START_DELAY= \
    UTORRENT_RUNAS_ROOT=false \
    UTORRENT_SETTING_DEFAULT=false \
    UTORRENT_WATCH_DIR=/data/watch \
    UTORRENT_INCOMPLETE_DIR=/data/incomplete \
    UTORRENT_DOWNLOAD_DIR=/data/completed \
    UTORRENT_HOME=/data/utorrent-home \
    UTORRENT_WEB_UI= \
    UTORRENT_BIND_IP=0.0.0.0 \
    UTORRENT_USERNAME=username \
    UTORRENT_PASSWORD=password

VOLUME /data

HEALTHCHECK --interval=5m --timeout=15s --start-period=30s CMD /usr/local/scripts/health.sh

EXPOSE 8080

CMD ["dumb-init", "/usr/local/scripts/startClient.sh"]
