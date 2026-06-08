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
