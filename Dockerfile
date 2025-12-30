FROM ubuntu:22.04

WORKDIR /workdir

COPY scripts/* /usr/local/bin/

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
RUN apt-get update && apt-get install -y \
    bash-completion \
    git \
    dnsutils \
    tmux \
    nmap \
    curl \
    tree \
    speedtest-cli \
    netcat \
    jq \
    zip \
    net-tools \
    iputils-ping \
    tcpdump \
    htop \
    vim \
     openssl \
     ca-certificates \
   && rm -rf /var/lib/apt/lists/* \
  && /usr/local/bin/get_kubectl.sh
