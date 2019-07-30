#!/bin/sh
API_KEY="WHATEVER"
EMAIL="chrissx@chrissx.ga"

while true ; do
        IP=$(curl http://ipinfo.io/ip)
        [ "$LAST_IP" = "$IP" ] && sleep 20 && continue
        curl -L -H "X-Auth-Email: $EMAIL" \
                -H "X-Auth-Key: $API_KEY" \
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"chrissx.ga","content":"'"$IP"'","ttl":120,"proxied":false}' \
                -X PUT \
                https://api.cloudflare.com/client/v4/zones/f26da62adcbb95b16f055a2dbd9fecf4/dns_records/a53863ddd00557a12736c9d442d90db4
        curl -L -H "X-Auth-Email: $EMAIL" \
                -H "X-Auth-Key: $API_KEY" \
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"zm.chrissx.ga","content":"'"$IP"'","ttl":120,"proxied":false}' \
                -X PUT \
                https://api.cloudflare.com/client/v4/zones/f26da62adcbb95b16f055a2dbd9fecf4/dns_records/f44514322e4986d180d016ae12a1aab2
        curl -L -H "X-Auth-Email: $EMAIL" \
                -H "X-Auth-Key: $API_KEY" \
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"zerm.chrissx.ga","content":"'"$IP"'","ttl":120,"proxied":false}' \
                -X PUT \
                https://api.cloudflare.com/client/v4/zones/f26da62adcbb95b16f055a2dbd9fecf4/dns_records/773207045238dab489f686548de22981
        LAST_IP="$IP"
        sleep 120
done
