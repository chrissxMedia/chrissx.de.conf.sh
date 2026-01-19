# ludwig

> [!CAUTION]
> This image has been deprecated and will be archived after 2026-02-31.
> Do not use it for new deployments!

`pygopherd` (2.0.18.5) in a Docker container. (Ubuntu 18.04 Bionic)

## Migrating

Since [the Ubuntu](https://ubuntu.com/about/release-cycle?product=ubuntu&release=ubuntu&version=18.04+LTS) [base image](https://hub.docker.com/layers/library/ubuntu/18.04/images/), [Python 2 language](https://www.python.org/downloads/release/python-2718/) and [pygopherd 2 server](https://github.com/jgoerzen/pygopherd) have not received standard security updates in years, it is strongly recommended to upgrade to [the PyGopherd 3 fork](https://github.com/michael-lazar/pygopherd) instead of trying to keep a pygopherd 2 instance running as is.

We initially planned on releasing a `ludwig:3` image that uses this new version, alongside Ubuntu 24.04 Noble, but decided against it for strategic reasons. Feel free to use the Dockerfile we prepared for this for any of your future endeavors:

```dockerfile
FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt autoremove -y
RUN apt install -y pygopherd
RUN rm -rf /var/gopher /etc/pygopherd/pygopherd.conf
COPY pygopherd.conf /etc/pygopherd/pygopherd.conf

ENTRYPOINT ["/usr/sbin/pygopherd"]
```

You should copy the default configuration to `pygopherd.conf`, set `detach = false` and remove the PID file path, as it is not needed inside Docker.

Page data is usually mounted at `/var/gopher`. Using [`deployment`](https://github.com/chrissxMedia/deployment), instead of putting it inside the image, is recommended.
