# tobias

Most of tobias in one compose project. It replaces the nginx with caddy.
ali and inventree are not part of this.

## Setup

1. `git clone https://github.com/chrissxMedia/chrissx.de.conf.sh.git /var/deployment/conf`
2. Copy `.env.example` to `.env` (`chmod 600`) and fill in `ACME_EMAIL` and
   `SIMON_TOKEN`. Only public repositories are deployed here, so unlike ruby
   there is no Git key and no `/ghpass`.
3. Switch nginx out (see below).
4. Go to `http://192.168.178.68:8123`, Settings > System > Network.
5. Set the external URL to `https://ha.chrissx.de`.
6. In HTTP server, enable Trust X-Forwarded-For and add Caddy's Docker network
   to Trusted proxies:
   ```sh
   docker network inspect tobias_webservices --format '{{(index .IPAM.Config 0).Subnet}}'
   ```
   Trusted proxies takes the network address, for example `172.20.0.0/16`. If
   Home Assistant logs a different untrusted proxy IP, use the subnet containing
   that IP. Confirm the HTTP settings after Home Assistant restarts.

## Switching nginx out

```sh
docker compose up -d deployment bucket homeassistant mumble simon watchtower
docker compose run --rm --no-deps caddy validate --config /etc/caddy/Caddyfile --adapter caddyfile
docker stop crazy_rosalind
docker compose up -d caddy
```

Home Assistant is the only site whose behavior changes: it was a 301 to
`http://192.168.178.68:8123` and is now proxied properly.

## After changing the Caddyfile

`deployment` pulls this repository, Caddy does not notice. Restart it:

```sh
docker compose restart caddy
```

## The mail certificate

Caddy issues the certificate for `mail.chrissx.de`. After each renewal, copy it
into Ali's `/mail` mount:

```bash
(
  set -euo pipefail
  docker compose exec -T caddy sh -c 'cat /data/caddy/certificates/*/mail.chrissx.de/mail.chrissx.de.crt' |
    docker exec -i ali sh -c 'umask 077; cat > /mail/fullchain.pem'
  docker compose exec -T caddy sh -c 'cat /data/caddy/certificates/*/mail.chrissx.de/mail.chrissx.de.key' |
    docker exec -i ali sh -c 'umask 077; cat > /mail/privkey.pem'
  docker exec ali sh -ec 'cp /mail/fullchain.pem /mail/cert.pem; chmod 0600 /mail/privkey.pem'
  docker restart ali
)
```

Until this is automated, a missed renewal means no mail for a while. Not pretty,
but not a regression either.
