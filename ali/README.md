# ali

A straight-forward Docker-distribution of `postfix` and `dovecot` with
`opendkim`.

First, make sure that the current directory contains the following files:

- `aliases.db`: a compiled `postmap` (`hash:`) database of aliases
- `users.passwd`: a `passwd` file with all the mail users and their (hashed)
  passwords
- `mail.private`: the private key for `opendkim` signing (please `chown 104:106`
  and `chmod 0600`)
- `cert.pem`, `fullchain.pem` and `privkey.pem` from your TLS certificate
- a `maildir` for every user

Then run the following command:

```sh
sudo docker run -d --restart=unless-stopped --pull=always -v$PWD:/mail \
-p25:25 -p143:143 -p465:465 -p587:587 -p993:993 --name ali chrissx/ali:latest
```

## Adding new users

```sh
userid=$((1000 + $(wc -l <users.passwd)))
grep $userid users.passwd # double-check that the uid isn't taken
hash=$(sudo docker exec -it ali doveadm pw)
echo "$username:$hash:$userid:8:,,,:/home/$username:/bin/bash" >> users.passwd
mkdir $username
sudo chown -R $userid:8 $username
sudo docker restart ali
```

## Adding new aliases

```sh
echo 'bar@chrissx.de foo@chrissx.de' >> aliases
sudo docker exec -it ali postmap hash:/mail/aliases
```

## Sending mail

Use port 587 with STARTTLS or port 465 with implicit TLS. Both require
authentication. Port 25 accepts incoming mail and does not offer AUTH.

The authenticated user must own both the SMTP envelope sender and the
message's `From` address. The inline `smtpd_sender_login_maps` rule derives
ownership from `username@chrissx.de`, so adding a user needs no extra map
entry. Usernames may contain ASCII letters, digits, underscores, dots,
plus signs and hyphens. Sender extensions do not grant ownership to the
base username.

The header filter uses Python's email parser and queries the same Postfix
map. Authenticated messages must have exactly one valid `From` header
containing one address. Empty envelope senders, such as read receipts,
still require an owned `From` address. If the filter or lookup fails,
submission temporarily fails. Incoming mail does not use this filter.
The existing `soft_bounce=yes` setting also makes policy rejections
temporary SMTP errors.

Receiving an alias does not automatically grant permission to send as it.
To let `foo` send as `bar@chrissx.de`, add an explicit rule before the
general rule in `main.cf`:

```ini
smtpd_sender_login_maps = regexp:{ { /^bar@chrissx\.de$$/ foo }, { /^([a-z0-9_.+-]+)@chrissx\.de$$/ $$1 } }
```

Rebuild and replace the container after changing the rule. Both address
checks use it. The doubled dollar signs escape Postfix's configuration
expansion.

See [Postfix sender ownership checks](https://www.postfix.org/postconf.5.html#smtpd_sender_login_maps),
[inline regex tables](https://www.postfix.org/regexp_table.5.html#inline_specification),
[Milter error handling](https://www.postfix.org/MILTER_README.html#per-milter),
and [Dovecot's submission configuration](https://doc.dovecot.org/2.3/configuration_manual/howto/postfix_and_dovecot_sasl/).
