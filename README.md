# [chrissx.de](https://chrissx.de) config files

These are most of the config files and scripts used for chrissx.de.

## Servers
We currently have around 7 servers, 5 of which are usually running at the
moment:

| Hostname     | Hardware                                    | Location  | OS                   | Other Software                               | Status                                       | Total Cost |
|--------------|---------------------------------------------|-----------|----------------------|----------------------------------------------|----------------------------------------------|------------|
| sophia       | Hetzner CX11                                | Nuremberg | Ubuntu Server 20.04  | nginx, pygopherd, redirector, jasmin         | running                                      | 3€/month   |
| rotmain      | Synology DS1821+, 8x Seagate IronWolf 8TB   | Pegnitz   | DSM 6                | RAID 5, youtube-dl, ...                      | running                                      | 3500€      |
| httpis       | Raspberry Pi 3B+                            | Pegnitz   | Raspbian Bullseye    | apache2/httpd                                | running                                      | 35€        |
| postpi       | Raspberry Pi 3B+                            | Pegnitz   | Raspbian Bullseye    | postfix, dovecot                             | running                                      | 35€        |
| optiplex3020 | Dell OptiPlex 3020                          | Pegnitz   | Ubuntu Server 20.04  | apt-cacher-ng, Minecraft, murmur             | running                                      | 80€        |
| veldenstein  | Custom (Pentium G4400 based), 4x WD Red 4TB | Pegnitz   | Ubuntu Desktop 20.04 | RAID 5                                       | not running, deployed as an emergency backup | 1000€      |
| ldapi        | Raspberry Pi 3B+                            | Pegnitz   | Raspbian Buster      | ldapd                                        | not running, to be removed                   | 35€        |

## Infrastructure
Currently our network is really fucked up, hopefully that might change soon.

### Switches
| Count | Model            | Price per Unit |
|-------|------------------|----------------|
| 2     | TP-Link TL-SG108 | 30€            |
| 1     | QNAP QSW-1105-5T | 130€           |
