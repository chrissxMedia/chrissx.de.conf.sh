# [chrissx.de](https://chrissx.de) config files

These are most of the config files and scripts used for chrissx.de.

## Servers
We currently have around 6 servers, 4 of which are usually running at
the moment:

| Hostname     | Hardware                                    | OS                   | Other Software                               | Status                                       |
|--------------|---------------------------------------------|----------------------|----------------------------------------------|----------------------------------------------|
| rotmain      | Synology DS1821+, 8x Seagate IronWolf 8TB   | DSM 6                | RAID 5, youtube-dl, ...                      | running                                      |
| httpis       | Raspberry Pi 3B+                            | Raspbian Buster      | apache2/httpd, pygopherd, redirector, jasmin | running                                      |
| postpi       | Raspberry Pi 3B+                            | Raspbian Buster      | postfix, dovecot                             | running                                      |
| optiplex3020 | Dell OptiPlex 3020                          | Ubuntu Server 20.04  | apt-cacher-ng, Minecraft, murmur             | running                                      |
| veldenstein  | Custom (Pentium G4400 based), 4x WD Red 4TB | Ubuntu Desktop 20.04 | RAID 5                                       | not running, deployed as an emergency backup |
| ldapi        | Raspberry Pi 3B+                            | Raspbian Buster      | ldapd                                        | not running, to be removed                   |
