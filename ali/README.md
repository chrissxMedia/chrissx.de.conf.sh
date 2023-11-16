# ali

A straight-forward Docker-distribution of `postfix` and `dovecot` with
`opendkim`.

First, make sure that the current directory contains the following files:

- `aliases.db`: a compiled `postalias` database
- `users.passwd`: a `passwd` file with all the mail users and their (hashed)
  passwords
- `mail.private`: the private key for `opendkim` signing (please `chown 104:106`
  and `chmod 0600`)
- `cert.pem`, `fullchain.pem` and `privkey.pem` from your TLS certificate
- a `maildir` with the name of every user (remember to `chown -R uid:8`, `uid`
  being the User ID from `users.passwd`)

Then run the following command:

```sh
sudo docker run -d --restart=unless-stopped --pull=always -v$PWD:/mail \
-p25:25 -p143:143 -p587:587 -p993:993 chrissx/ali:latest
```

## Adding new users

```sh
userid=10$(wc -l users.passwd | awk '{ print $1 }')
hash=$(sudo docker exec -it $my_ali_instance doveadm pw)
echo "$username:$hash:$userid:8:,,,:/home/$username:/bin/bash" >> users.passwd
mkdir $username
sudo chown -R $userid:8 $username
sudo docker restart $my_ali_instance
```
