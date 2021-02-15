# [chrissx.de](https://chrissx.de) config files

These are most of the config files and scripts used for chrissx.de.

## Servers
We currently have around 6 servers, 4 of which are usually running at
the moment:

| Hostname     | Hardware                                    |
|--------------|---------------------------------------------|
| rotmain      | Synology DS1821+, 8x Seagate IronWolf 8TB   |
| httpis       | Raspberry Pi 3B+                            |
| postpi       | Raspberry Pi 3B+                            |
| optiplex3020 | Dell OptiPlex 3020                          |
| veldenstein  | Custom (Pentium G4400 based), 4x WD Red 4TB |
| ldapi        | Raspberry Pi 3B+                            |

| Hostname     | OS                   | Other Software                               |
|--------------|----------------------|----------------------------------------------|
| rotmain      | DSM 6                | RAID 5, youtube-dl, ...                      |
| httpis       | Raspbian Buster      | apache2/httpd, pygopherd, redirector, jasmin |
| postpi       | Raspbian Buster      | postfix, dovecot                             |
| optiplex3020 | Ubuntu Server 20.04  | apt-cacher-ng, Minecraft, murmur             |
| veldenstein  | Ubuntu Desktop 20.04 | RAID 5                                       |
| ldapi        | Raspbian Buster      | ldapd                                        |

| Hostname     | Status                                       |
|--------------|----------------------------------------------|
| rotmain      | running                                      |
| httpis       | running                                      |
| postpi       | running                                      |
| optiplex3020 | running                                      |
| veldenstein  | not running, deployed as an emergency backup |
| ldapi        | not running, to be removed                   |
