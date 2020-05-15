# Docker uTorrent client

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/spiritsree/docker-client-utorrent)](https://hub.docker.com/r/spiritsree/docker-client-utorrent)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/spiritsree/docker-client-utorrent)](https://hub.docker.com/r/spiritsree/docker-client-utorrent)
[![Docker Pulls](https://img.shields.io/docker/pulls/spiritsree/docker-client-utorrent)](https://hub.docker.com/r/spiritsree/docker-client-utorrent/tags)
[![Docker Stars](https://img.shields.io/docker/stars/spiritsree/docker-client-utorrent)](https://hub.docker.com/r/spiritsree/docker-client-utorrent)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/spiritsree/docker-client-utorrent?sort=semver)
[![License](https://img.shields.io/github/license/spiritsree/docker-client-utorrent)](https://github.com/spiritsree/docker-client-utorrent/blob/master/LICENSE.md)

A configurable uTorrent docker client based out of Ubuntu image


## Quick Start

You can run this by just running the following

```
docker run -d \
        --sysctl net.ipv6.conf.all.disable_ipv6=0 \
        --dns 8.8.8.8 --dns 8.8.4.4 \
        -v <local-dir>:/data \
        -p 8080:8080 \
        spiritsree/docker-client-utorrent:latest
```

For detailed usage and to pair it with VPN container please refer [Usage](./docs/usage.md).

## Accessing the UI

Just put this in browser `http://<local-ip>:8080/gui`.

For more details visit [Accessing the UI](./docs/web-ui.md).

## Documentation

* [Usage](./docs/usage.md)
* [Supported Environment Variables](./docs/env.md)
* [Accessing the UI](./doc/web-ui.md)
* [Docker Options](https://github.com/spiritsree/docker-torrent-client/blob/master/doc/docker.md)
* [Debugging](https://github.com/spiritsree/docker-torrent-client/blob/master/doc/debug.md)
* [Container Networking](https://github.com/spiritsree/docker-torrent-client/blob/master/doc/networking.md)

## LICENSE

GPL-v3.0

