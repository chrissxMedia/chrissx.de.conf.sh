FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

# TODO: configurability
#ARG DOMAIN=chrissx.de

RUN apt update && apt upgrade -y && apt autoremove -y
RUN apt install -y postfix dovecot-imapd dovecot-lmtpd opendkim

RUN service postfix stop
RUN service dovecot stop
RUN service opendkim stop

COPY main.cf /etc/postfix/main.cf
COPY master.cf /etc/postfix/master.cf
COPY header_checks /etc/postfix/header_checks

COPY dovecot.conf /etc/dovecot/dovecot.conf

COPY opendkim.conf /etc/opendkim.conf
COPY keytable /etc/postfix/dkim/keytable
COPY signingtable /etc/postfix/dkim/signingtable

COPY start.sh /start.sh
CMD /start.sh
