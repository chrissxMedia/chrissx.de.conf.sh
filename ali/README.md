# ali

A straight-forward Docker-distribution of `postfix` and `dovecot` with
`opendkim`.

First, make sure that you have a Let's Encrypt certificate at
`/etc/letsencrypt/live/rosenhof.chrissx.de/`, or adjust the command below
accordingly, and the current directory contains the following files:

- `aliases.db`: a compiled `postalias` database
- `users.passwd`: a `passwd` file with all the mail users and their passwords
- `mail.private`: the private key for `opendkim` signing (please `chown 104:106`
  and `chmod 0600`)
- a `maildir` with the name of every user (remember to `chown -R uid:8`, `uid`
  is the User ID from the `users.passwd`)

Then run the following command:

```sh
sudo docker run -d --restart=always -v$PWD:/mail -v/etc/letsencrypt/live/rosenhof.chrissx.de/cert.pem:/mail/cert.pem -v/etc/letsencrypt/live/rosenhof.chrissx.de/fullchain.pem:/mail/fullchain.pem -v/etc/letsencrypt/live/rosenhof.chrissx.de/privkey.pem:/mail/privkey.pem -p25:25 -p143:143 -p587:587 -p993:993 chrissx/ali
```
