#!/bin/sh
API_KEY="WHATEVER"
EMAIL="chrissx@chrissx.de"

while true ; do
        IP=$(curl http://ipinfo.io/ip)
        [ "$LAST_IP" = "$IP" ] && sleep 60 && continue
        curl -L -H "X-Auth-Email: $EMAIL" \
                -H "X-Auth-Key: $API_KEY" \
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"rosenhof.chrissx.de","content":"'"$IP"'","ttl":120,"proxied":false}' \
                -X PUT \
                https://api.cloudflare.com/client/v4/zones/08bd4c50de27d76b981bfe6b8c911a97/dns_records/6016d3dd55f04e871a5ef61df41f52d0
        LAST_IP="$IP"
        sleep 120
done
