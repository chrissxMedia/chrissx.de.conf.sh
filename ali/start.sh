#!/bin/sh
set -ue

pids=""
start_svc() {
  ( "$@" ) &
  p="$!"
  pids="$pids $p"
}

mkdir -p /mail/queue /mail/dovecot
# Prepare the queue before Dovecot binds its sockets there.
postfix set-permissions
postfix check

start_svc postfix start-fg
start_svc dovecot -F
start_svc opendkim -f

kill_and_exit() {
  for pid in $pids; do
    kill "$pid" 2>/dev/null || true
  done
  exit $1
}

trap 'kill_and_exit 130' INT TERM

while true; do
  for pid in $pids; do
    if ! kill -0 "$pid" 2>/dev/null; then
      wait "$pid"
      kill_and_exit $?
    fi
  done
  sleep 1
done
