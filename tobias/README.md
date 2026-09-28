# tobias

Most of tobias in one compose project. It replaced the nginx with caddy.
ali and inventree are not part of this.

## Setup

1. `git clone https://github.com/chrissxMedia/chrissx.de.conf.sh.git /home/pixel/deployment/conf`
2. Copy `.env.example` to `.env` (`chmod 600`) and fill in `ACME_EMAIL` and
   `SIMON_TOKEN`. Only public repositories are deployed here, so unlike ruby
   there is no Git key and no `/ghpass`.
3. Deploy the services (see below).
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

## Deploy

```sh
docker compose run --rm --no-deps caddy caddy validate --config /etc/caddy/Caddyfile --adapter caddyfile
docker compose up -d
```

## After changing the Caddyfile

`deployment` pulls this repository, Caddy does not notice. Restart it:

```sh
docker compose restart caddy
```
