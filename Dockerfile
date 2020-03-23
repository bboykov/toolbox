FROM ubuntu:18.04

WORKDIR /workdir

COPY scripts/* /usr/local/bin/

RUN apt-get update \
  && apt-get install -y \
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
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip && ./aws/install && rm awscliv2.zip && rm -rf ./aws/ \
  && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
  && chmod 700 get_helm.sh && mv get_helm.sh /usr/local/bin/ \
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

CMD ["bash"]
