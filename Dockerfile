FROM ubuntu:18.04

WORKDIR /workdir

RUN apt-get update \
  && apt-get install -y \
    git \
    dnsutils \
    tmux \
    nmap \
    curl \
    tree \
    speedtest-cli \
    netcat

CMD ["bash"]
