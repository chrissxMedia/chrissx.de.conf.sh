# Monitoring

Uptime Kuma 2 and AutoKuma 2 run on ruby and rotmain from this directory.
Each host keeps its own database and sends its own alerts.

## Setup

On each host, in this directory:

1. Copy `.env.example` to `.env` (`chmod 600`), fill in Kuma, Discord, SMTP
   and Pushover credentials. Quote values containing `$`.
2. Set `SITE` to `ruby` or `rotmain`. It selects that host's internal monitors.
3. Generate two push tokens (`openssl rand -hex 16`). Each host's
   `OWN_PUSH_TOKEN` is the other's `PEER_PUSH_TOKEN`; `PEER_URL` is the other
   host's dedicated HTTPS name.
4. `docker compose up -d kuma`, expose port 3001 via tunnel or proxy, and
   create the admin account from `.env`.
5. `docker compose up -d autokuma`, then check its logs and the dashboard.
   Notifications may take one more sync cycle to attach.

Secrets stay out of Git, but Kuma stores credentials in its database, so back
up both named volumes. Watchtower is disabled for both images.
Email uses `SMTP_USERNAME` as the sender address and `mail.chrissx.de` as the
default SMTP host.

## Proxy

Serve `status-ruby`/`status-rotmain` per site and `status.chrissx.de` from
both. Port 3001 binds localhost by default, which is fine; peer checks use
the public `PEER_URL`. Only set `KUMA_BIND_ADDRESS` to the LAN address if
Tobias proxies rotmain over LAN, and keep it private. On ruby join nginx to
`monitoring_default`. Proxy needs WebSocket forwarding:

```nginx
location / {
    proxy_pass http://kuma:3001;
    include /etc/nginx/conf.d/proxy_params;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 60s;
}
```

The peer must reach `/api/push/` without extra login. Treat push URLs as
secrets.

## Alerts

Checks run every 30s. High allows 4 retries (~2min); internal services allow
20 (~10min). High Pushover notifications, including recoveries, use emergency
priority 2 (repeat 30s, expire after 1h); low stays at priority -1. Discord
suppresses low; high optionally mentions `DISCORD_MENTION`. Email is one
notification for both priorities, no importance headers. Each instance
identifies itself; public outages normally alert from both sites. The peer
heartbeat alerts after ~2min without a push, catching stalled loops too.

## Coverage

Public HTTP checks follow ruby's nginx config and Tobias's TLS names, reject
4xx/5xx, and check TLS. Apex domains only, no `www` duplicates; anything
without a file has no check. External destinations and imported
assets have no checks. Metrics endpoints cover Erwin, Jasmin, redirector,
Docker and Bucket (no history or per-container state). Mail checks TCP
25/465/587/143/993, so they do not test mail delivery. Only rotmain checks
Mumble over LAN at `op.chrissx.de:64738`; its TCP check does not test UDP
voice traffic. Rotmain also checks Home Assistant, InvenTree and Tobias-direct
Docker/Bucket. Jana, insp8n and aggregamus are excluded; nginx `stub_status`
is not Prometheus format.

## Managing

Deploy the same revision to both hosts. Restart AutoKuma after `autokuma.toml`
changes, recreate after `.env`. Filenames are monitor IDs, so renames create
new monitors; `on_delete = "keep"` guards missing mounts. Delete obsolete
monitors manually in both instances; UI edits to managed objects are
overwritten.

`NOTIFICATIONS_HIGH`/`NOTIFICATIONS_LOW` in `docker-compose.yaml` route
centrally; recreate AutoKuma after editing. There are no group aliases. New
channels need a notification file plus credentials.

Templates mix AutoKuma Tera (credentials) with Kuma Liquid (content);
`applyExisting = false` avoids endless notification updates.

Create the `status` status page manually per instance with the same slug and
domain, public monitors only. Its groups need numeric monitor IDs, so it stays
UI-managed. Keep peer monitors off it, especially the sender with the token.

Before relying on alerts, test each notification, trip a temporary failing
monitor per priority, and pause the peer sender for two minutes. Back up the
volumes before upgrading either image.
