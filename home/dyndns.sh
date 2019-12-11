#!/bin/sh
API_KEY="WHATEVER"
EMAIL="chrissx@chrissx.ga"

while true ; do
        IP=$(curl http://ipinfo.io/ip)
        [ "$LAST_IP" = "$IP" ] && sleep 60s && continue
        curl -L -H "X-Auth-Email: $EMAIL" \
                -H "X-Auth-Key: $API_KEY" \
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"zerm.eu","content":"'"$IP"'","ttl":120,"proxied":false}' \
                -X PUT \
                https://api.cloudflare.com/client/v4/zones/b18c50790ce69441a2da12d8a78d1d02/dns_records/ba9aed375cf831f245b06e74be22c6f9
        curl -L -H "X-Auth-Email: $EMAIL" \
                -H "X-Auth-Key: $API_KEY" \
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"zerm.link","content":"'"$IP"'","ttl":120,"proxied":false}' \
                -X PUT \
                https://api.cloudflare.com/client/v4/zones/623a7431ffe2bcc4f9a3ba85c1eb89a9/dns_records/15274d7a7fb5d2ab58f4409116da008c
        curl -L -H "X-Auth-Email: $EMAIL" \
                -H "X-Auth-Key: $API_KEY" \
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"chrissx.de","content":"'"$IP"'","ttl":120,"proxied":false}' \
                -X PUT \
                https://api.cloudflare.com/client/v4/zones/08bd4c50de27d76b981bfe6b8c911a97/dns_records/449d24589c8ade29c9624448657566e9
        curl -L -H "X-Auth-Email: $EMAIL" \
                -H "X-Auth-Key: $API_KEY" \
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"chrissx.eu","content":"'"$IP"'","ttl":120,"proxied":false}' \
                -X PUT \
                https://api.cloudflare.com/client/v4/zones/83843912397f637517f05b857b05c2e1/dns_records/0bc21fde502de4b36e15f07eb053bbd4
        LAST_IP="$IP"
        sleep 240s
done
