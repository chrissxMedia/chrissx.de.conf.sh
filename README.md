# [chrissx.de](https://chrissx.de) config files

These are most of the config files and scripts used for chrissx.de.

## Servers
We currently have around 7 servers, 4 of which are usually running at
the moment:

| Name               | Hardware           | Software                                                              | Status                                |
| -------------------|--------------------|-----------------------------------------------------------------------|---------------------------------------|
| Veldenstein-Server | Custom NAS (12TB)  | Windows 10 Pro                                                        | running, to be replaced               |
| httpis             | Raspberry Pi 3B+   | Raspbian Buster, apache2 (httpd), pygopherd, redirector, static-short | running                               |
| postpi             | Raspberry Pi 3B+   | Raspbian Buster, postfix, dovecot                                     | running                               |
| optiplex3020       | Dell OptiPlex 3020 | Ubuntu Server 20.04, apt-cacher-ng, Minecraft, murmur                 | running                               |
| ldapi              | Raspberry Pi 3B+   | Raspbian Buster, ldapd                                                | not running                           |
| nextpi             | Raspberry Pi 4B    | Raspbian Buster, Nextcloud                                            | not running                           |
| dlpi/grabpi        | Raspberry Pi 3B+   | Raspbian Buster, youtube-dl, curl                                     | not running, half-merged into the NAS |
