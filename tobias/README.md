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

## Ferdium accounts

Run these commands in Bash from `tobias/`. The first start creates the database
`ferdium.sqlite` and signing keys in `/home/pixel/deployment/data/ferdium/`.
Registration is disabled. SMTP is not configured, so email password recovery
is unavailable. Replace the example email and password below.

```bash
docker compose up -d --wait ferdium
ferdium_email='you@chrissx.de'
ferdium_password='your-password'
ferdium_salt=$(openssl rand -base64 16)
ferdium_salt_hex=$(echo -n "$ferdium_salt" | base64 -d | od -An -v -tx1 | tr -d ' \n')
ferdium_key=$(openssl kdf -binary -keylen 64 \
  -kdfopt "pass:$(echo -n "$ferdium_password" | openssl dgst -sha256 -binary | base64 -w 0)" \
  -kdfopt "hexsalt:$ferdium_salt_hex" \
  -kdfopt n:16384 -kdfopt r:8 -kdfopt p:1 SCRYPT | base64 -w 0 | tr -d '=')
ferdium_hash='$scrypt$n=16384,r=8,p=1$'"${ferdium_salt//=}"'$'"$ferdium_key"
sqlite3 -bail /home/pixel/deployment/data/ferdium/ferdium.sqlite <<SQL
.timeout 5000
INSERT INTO users (username, email, password, lastname)
VALUES ('${ferdium_email%%@*}', '$ferdium_email', '$ferdium_hash', '');
SQL
```

The OpenSSL commands apply SHA-256/base64 and scrypt with Ferdium's default
parameters. `.timeout 5000` waits up to five seconds if Ferdium holds a database
write lock. To add another account, repeat the commands after `up`.
In Ferdium, select Change Server and enter `https://ferdium.chrissx.de`.
Back up the data directory, including its keys, with Ferdium stopped.

## After changing the Caddyfile

`deployment` pulls this repository, Caddy does not notice. Restart it:

```sh
docker compose restart caddy
```
