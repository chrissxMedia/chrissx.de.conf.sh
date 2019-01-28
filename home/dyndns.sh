#!/bin/sh
while true
do
        IP=$(curl -o - http://ipinfo.io/ip)
        curl -L -H "X-Auth-Email: chrissx@chrissx.ga" \
                -H "X-Auth-Key: _INSERT_API_KEY_" \
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"chrissx.ga","content":"'"$IP"'","ttl":120,"proxied":false}' \
                -X PUT -o - \
                https://api.cloudflare.com/client/v4/zones/f26da62adcbb95b16f055a2dbd9fecf4/dns_records/a53863ddd00557a12736c9d442d90db4
        sleep 120
done
