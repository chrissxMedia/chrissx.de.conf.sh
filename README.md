# chrissx.de config files

> [!NOTE]
> We have big changes coming, which are [listed on our website](https://chrissx.de/#notices).

These are most of the config files and scripts used on chrissx Media operated infrastructure.

## Infrastructure

```mermaid
graph LR

subgraph rosenhof["Rosenhof (cM Infra)"]
  rotmain

  subgraph tobias
    subgraph dockerop[docker]
      simon
      tor-proxy
      nginxop[nginx]
      ludwigop[ludwig]
      ali
      murmur
      minecraft
      home-assistant
      inventree
      bucket
      watchtowertobias[watchtower]
    end
    backup.timer
    nginxop -- 1339 --> inventree
    nginxop -- 8123 --> home-assistant
    nginxop -- 8022 --> bucket
  end
  backup.timer -- 873 --> rotmain
end

subgraph nuremberg["Nuremberg (Hetzner Infra)"]
  subgraph sophia
    nginxsophia[nginx]
    subgraph dockersophia[docker]
      inspiriererin
      jana -- 2333 --> lavalink
      ludwigsophia[ludwig]
      redirector
      kinkcheck.top
      bottom.kinkcheck.top
      jasmin
      erwin
      watchtowersophia[watchtower]
    end
    nginxsophia -- 4321 --> kinkcheck.top
    nginxsophia -- 4322 --> bottom.kinkcheck.top
    nginxsophia -- 8099 --> jasmin
    nginxsophia -- 8080 --> erwin
    deployment
  end
end

simon --> nginxsophia;

internet(Users)
internet -- "9053, 9052, 9050" --> tor-proxy
internet -- "443, 80" --> nginxop[nginx]
internet -- 70 --> ludwigop[ludwig]
internet -- "993, 143, 587, 25" --> ali
internet -- 64738 --> murmur
internet -- 25565 --> minecraft
internet -- 443 --> nginxsophia
internet -- 70 --> ludwigsophia[ludwig]
internet -- 80 --> redirector
internet -- 8080 --> erwin
discord(discord.com)
inspiriererin --> discord
jana --> discord

classDef docker fill:#0092e7,stroke:#000
class dockerop docker
class dockersophia docker
classDef location fill:#000,stroke:#808080
class rosenhof location
class nuremberg location
classDef server fill:#222,stroke:#000
class tobias server
class rotmain server
class sophia server

click tor-proxy "https://github.com/pixelcmtd/docker-containers/tree/master/tor-proxy" _blank
click ludwigop "https://github.com/chrissxMedia/chrissx.de.conf.sh/tree/master/ludwig" _blank
click simon "https://github.com/chrissxMedia/chrissx.de.conf.sh/tree/master/simon" _blank
click ali "https://github.com/chrissxMedia/chrissx.de.conf.sh/tree/master/ali" _blank
click murmur "https://github.com/mumble-voip/mumble-docker" _blank
click minecraft "https://github.com/itzg/docker-minecraft-server" _blank
click home-assistant "https://github.com/home-assistant/core" _blank
click inventree "https://docs.inventree.org/en/latest/start/docker/" _blank
click bucket "https://github.com/pixelcmtd/bucket" _blank
click watchtowertobias "https://containrrr.dev/watchtower/" _blank
click aggregamus "https://github.com/Ampless/aggregamus" _blank
click ludwigsophia "https://github.com/chrissxMedia/chrissx.de.conf.sh/tree/master/ludwig" _blank
click inspiriererin "https://github.com/pixelcmtd/Inspiriererin" _blank
click jana "https://github.com/chrissxMedia/jana" _blank
click lavalink "https://github.com/lavalink-devs/Lavalink/pkgs/container/lavalink" _blank
click redirector "https://github.com/chrissxMedia/redirector" _blank
click watchtowersophia "https://containrrr.dev/watchtower/" _blank
click kinkcheck.top "https://github.com/chrissxMedia/KinkCheck.Top" _blank
click bottom.kinkcheck.top "https://github.com/chrissxMedia/KinkCheck.Top/tree/bottom" _blank
click jasmin "https://github.com/ZERMZeitung/jasmin" _blank
click erwin "https://github.com/chrissxMedia/erwin" _blank
click deployment "https://github.com/chrissxMedia/deployment" _blank
```

### Hardware

| Hostname    | Hardware                                    | Location  | OS                   | Status                | Cost    |
| ----------- | ------------------------------------------- | --------- | -------------------- | --------------------- | ------- |
| sophia      | Hetzner CX11                                | Nuremberg | Ubuntu Server 22.04  | running               | 5.3€/mo |
| tobias      | Lenovo ThinkCentre M710s                    | Rosenhof  | Ubuntu Server 22.04  | running               | 140€    |
| rotmain     | Synology DS1821+, 8x Seagate IronWolf 8TB   | Rosenhof  | DSM 7                | running               | 3500€   |
| veldenstein | Custom (Pentium G4400 based), 4x WD Red 4TB | Rosenhof  | Ubuntu Desktop 22.04 | emergency cold backup | 1000€   |

### DNS

#### Internal

> [!NOTE]
> For some reason `tobias.chrissx.de` gets lost somewhere in the chain of DNS servers most of the time, so we use `op.chrissx.de` (named after the old `optiplex`) instead.

| Type  | Name                   | Content               |
| ----- | ---------------------- | --------------------- |
| A     | `op.chrissx.de`        | `192.168.178.68`      |
| A     | `rotmain.chrissx.de`   | `192.168.178.29`      |

#### External

| Type  | Name                           | Content                    |
| ----- | ------------------------------ | -------------------------- |
| A     | `rosenhof.chrissx.de`          | (DynDNS)                   |
| AAAA  | `rosenhof.chrissx.de`          | (DynDNS)                   |
| A     | `sophia.chrissx.de`            | `78.47.163.103`            |
| AAAA  | `sophia.chrissx.de`            | `2a01:4f8:c0c:69c8::`      |
| CAA   | `chrissx.de`                   | `0 issue letsencrypt.org`  |
| MX    | `chrissx.de`                   | `mail.chrissx.de`          |
| CNAME | `ampless.chrissx.de`           | `sophia.chrissx.de`        |
| CNAME | `amplus.chrissx.de`            | `sophia.chrissx.de`        |
| CNAME | `autoconfig.chrissx.de`        | `rosenhof.chrissx.de`      |
| CNAME | `bucket.chrissx.de`            | `rosenhof.chrissx.de`      |
| CNAME | `cpm.chrissx.de`               | `sophia.chrissx.de`        |
| CNAME | `fonts.chrissx.de`             | `sophia.chrissx.de`        |
| CNAME | `ftp.chrissx.de`               | `rosenhof.chrissx.de`      |
| CNAME | `get.cpm.chrissx.de`           | `sophia.chrissx.de`        |
| CNAME | `git.chrissx.de`               | `rosenhof.chrissx.de`      |
| CNAME | `ha.chrissx.de`                | `rosenhof.chrissx.de`      |
| CNAME | `inv.chrissx.de`               | `rosenhof.chrissx.de`      |
| CNAME | `lyrics.chrissx.de`            | `sophia.chrissx.de`        |
| CNAME | `mail.chrissx.de`              | `rosenhof.chrissx.de`      |
| CNAME | `mc.chrissx.de`                | `rosenhof.chrissx.de`      |
| CNAME | `media.chrissx.de`             | `sophia.chrissx.de`        |
| CNAME | `meme.chrissx.de`              | `sophia.chrissx.de`        |
| CNAME | `mumble.chrissx.de`            | `rosenhof.chrissx.de`      |
| CNAME | `new.chrissx.de`               | `sophia.chrissx.de`        |
| CNAME | `old.chrissx.de`               | `sophia.chrissx.de`        |
| CNAME | `pad.chrissx.de`               | `sophia.chrissx.de`        |
| CNAME | `penis.chrissx.de`             | `sophia.chrissx.de`        |
| CNAME | `pixel.chrissx.de`             | `sophia.chrissx.de`        |
| CNAME | `porn.chrissx.de`              | `sophia.chrissx.de`        |
| CNAME | `qa.chrissx.de`                | `sophia.chrissx.de`        |
| CNAME | `screwed.chrissx.de`           | `sophia.chrissx.de`        |
| CNAME | `tor.chrissx.de`               | `op.chrissx.de`            |
| CNAME | `wiki.chrissx.de`              | `sophia.chrissx.de`        |
| CNAME | `chrissx.de`                   | `sophia.chrissx.de`        |
| CNAME | `chrisxeric.de`                | `sophia.chrissx.de`        |
| CNAME | `elonisnwichser.de`            | `sophia.chrissx.de`        |
| CNAME | `fuxgames.com`                 | `sophia.chrissx.de`        |
| CNAME | `gock.dev`                     | `sophia.chrissx.de`        |
| CNAME | `kinkcheck.top`                | `sophia.chrissx.de`        |
| CNAME | `lowlevelmusic.com`            | `sophia.chrissx.de`        |
| CNAME | `zerm.eu`                      | `sophia.chrissx.de`        |
| CNAME | `zerm.link`                    | `sophia.chrissx.de`        |
| CNAME | `www.chrissx.de`               | `chrissx.de`               |
| CNAME | …                              | …                          |
| CNAME | `www.zerm.link`                | `zerm.link`                |

<!-- vim: set wrap! : -->
