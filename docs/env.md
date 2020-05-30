# Environment Variable Used

There are many environment variable which can be passed to the docker to customize the config and other parameters.

## General

Variable | Description | Default |
:--------|:------------|:--------|
`LOG_FILE` | The log file path | `/data/application.log` |
`ENABLE_FILE_LOGGING` | `true` enables logging to file, `false` will use docker logs | `true` |
`HEALTH_CHECK_HOST` | Docker health check host | `www.google.com` |

## uTorrent

All these are set in the config directly with default during the intial run. If you set these ENV during the docker run, those settings will have the precedence. If not set, the value will get constructed from the config file (if previous config exists).

**General**

Variable | Description | Default |
:--------|:------------|:--------|
`UTORRENT_RUNAS_ROOT` | Run uTorrent client as root user | `false` |
`UTORRENT_SETTING_DEFAULT` | Use the default config | `false` |
`UTORRENT_HOME` | uTorrent Home | `/data/utorrent-home` |
`UTORRENT_LOGMASK` | Mask to allow generating certain categories of log message | `0` |
`UTORRENT_FINISH_CMD` | command that will be executed upon completion of each torrent |  |
`UTORRENT_START_DELAY` | Startup delay in seconds | |

**Directories**

Variable | Description | Default |
:--------|:------------|:--------|
`UTORRENT_INCOMPLETE_DIR` | Directory for ongoing torrents | `/data/incomplete` |
`UTORRENT_DOWNLOAD_DIR` | Directory for completed torrents | `/data/completed` |
`UTORRENT_WATCH_DIR` | Directory to watch for torrent files and add them to torrent client | `/data/watch` |
`UTORRENT_DIR_AUTOLOAD_DELETE` | If true, torrent files in the watch directory will be deleted after being loaded, else they will be renamed with an extension of .loaded | `false`

**Connection**

Variable | Description | Default |
:--------|:------------|:--------|
`UTORRENT_UPNP` | Enable UPnP port mapping | `false` |
`UTORRENT_NATPMP` | Enable NAT-PMP port mapping | `false` |
`UTORRENT_RANDOMIZE_BIND_PORT` | Enable selecting random port every start of the client | `false` |
`UTORRENT_UCONNECT_ENABLE` | Enable remote access | `false` |
`UTORRENT_UCONNECT_USERNAME` | Remote access username | |
`UTORRENT_UCONNECT_PASSWORD` | Remote access password | |
`UTORRENT_TOKEN_AUTH_FILTER` | Determines which set of IP addresses will require the use of token authentication | `all` |

**Bandwidth**

Variable | Description | Default |
:--------|:------------|:--------|
`UTORRENT_MAX_UL_RATE` | Maximum upload rate (kB/s) | `-1` |
`UTORRENT_MAX_DL_RATE` | Maximum download rate (kB/s) | `-1` |
`UTORRENT_CONNS_PER_TORRENT` | Maximum number of connected peers per torrent |  `50` |
`UTORRENT_MAX_TOTAL_CONNECTIONS` | Global maximum number of connections |  `200` |
`UTORRENT_RATE_LIMIT_LOCAL_PEERS` | rate limiting also applies to communications with peers in the local subnet | `false` |
`UTORRENT_MAX_UL_RATE_SEED` | Maximum per-torrent upload rate when seeding (kB/s) | `-1` |
`UTORRENT_AUTO_BANDWIDTH_MANAGEMENT` | upload bandwidth is automatically throttled in order to not impact other applications using TCP/IP | `true` |

**Network**

Variable | Description | Default |
:--------|:------------|:--------|
`UTORRENT_LSD` | Local Service Discovery is enabled | `true` |
`UTORRENT_DHT` | Distributed Hash Table extension is enabled | `true` |
`UTORRENT_PEX` | Peer Exchange extension is enabled | `true` |
`UTORRENT_BIND_IP` | uTorrent bind IP | `0.0.0.0` |
`UTORRENT_BIND_PORT` | Port used for bittorrent protocol | `6881` |
`UTORRENT_LOW_CPU` | Enable short sleep during the process of handling network traffic | `false` |

**Queueing**

Variable | Description | Default |
:--------|:------------|:--------|
`UTORRENT_SEED_RATIO` | Minimum seed ratio (%) | `0` |
`UTORRENT_SEED_TIME` | Minimum seeding time (minutes) | `0` |
`UTORRENT_SEQUENTIAL_DOWNLOAD` | torrent pieces are requested in order | `false` |
`UTORRENT_COMPACT_ALLOCATION` | torrent pieces are appended to the end of the files as they come in and rearranged dynamically | `false` |
`UTORRENT_PREALLOC_SPACE` | disk space for a torrent is allocated before the first piece is written to disk | `false` |

**Web UI**

Variable | Description | Default |
:--------|:------------|:--------|
`UTORRENT_WEB_UI` | uTorrent web UI `default` or `ng` | |
`UTORRENT_USERNAME` | Web UI username | `username` |
`UTORRENT_PASSWORD` | Web UI password | `password` |
`UTORRENT_UT_WEBUI_PORT` | Web UI port | `8080` |
`UTORRENT_TOKEN_AUTH_ENABLE` | the µTorrent HTTP interface defends against cross-site request forgeries by requiring that a short-lived token be obtained from the µTorrent HTTP interface and included at the beginning of the parameter list of any request made to that interface | `false` |
`UTORRENT_LOCALHOST_AUTHENTICATION` | Enable authentication for HTTP requests originating from the localhost | `true` |


**Memory**

Variable | Description | Default |
:--------|:------------|:--------|
`UTORRENT_DISK_CACHE_MAX_SIZE` | Maximum amount of memory (MB) used by each of the read, write, and piece caches. 0 accepts the server's default | `0` |
`UTORRENT_WRITE_COALESCE_MAX_SIZE` | The maximum amount of contiguous torrent file data (in MB) that will be held before writing it to disk. Adjusting this value may affect disk write efficiency on some systems | `0` |
`UTORRENT_PROGRESSIVE_PIECE_SPAN` | The maximum amount of readahead (in MB) for torrents that are being downloaded in the more sequential progressive mode (as opposed to the more random rarest-first mode) | `0` |
`UTORRENT_MINIMIZE_KERNEL_CACHING` | Enable synchronous I/O | `false` |
`UTORRENT_ALL_WRITES_SYNC` | all writable disk handles opened are flagged for synchronous I/O disk space for a torrent is allocated before the first piece is written to disk | `false` |
`UTORRENT_ENCRYPT_BUFFER_SIZE` | encryption buffer allocated for SSL communications | `102400` |

