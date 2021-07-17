FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt autoremove -y
RUN apt install -y pygopherd git

RUN service pygopherd stop
RUN rm -rf /var/gopher
RUN git clone https://github.com/chrissxMedia/chrissx.de-70.git /var/gopher
RUN service pygopherd start

COPY gitpull /usr/local/bin/gitpull
CMD /usr/local/bin/gitpull
