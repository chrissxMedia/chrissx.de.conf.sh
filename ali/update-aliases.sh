#!/bin/bash
set -euo pipefail

postmap hash:/mail/aliases

sender_logins=$(mktemp /mail/sender_logins.XXXXXX)
trap 'rm -f "$sender_logins"' EXIT

postmap -s hash:/mail/aliases |
  while read -r sender destinations; do
    sender=${sender,,}
    [[ $sender =~ ^[a-z0-9_.+-]+@chrissx\.de$ ]] || continue
    owners=${sender%@*}
    read -ra recipients <<< "${destinations//,/ }"
    for recipient in "${recipients[@]}"; do
      recipient=${recipient,,}
      if [[ $recipient =~ ^[a-z0-9_.+-]+@chrissx\.de$ ]]; then
        owners+=" ${recipient%@*}"
      fi
    done
    sender=${sender//./\\.}
    sender=${sender//+/\\+}
    printf '/^%s$/ %s\n' "$sender" "$owners"
  done > "$sender_logins"

cat >> "$sender_logins" <<'EOF'
/^([a-z0-9_.+-]+)@chrissx\.de$/ $1
EOF
chmod 644 "$sender_logins"
mv "$sender_logins" /mail/sender_logins

if postfix status >/dev/null 2>&1; then
  postfix reload
fi
