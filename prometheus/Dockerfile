FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt upgrade -y
RUN apt install -y prometheus

RUN rm -rf /etc/prometheus

EXPOSE 9090
