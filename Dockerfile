FROM debian:stretch

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
    apt-transport-https \
    gnupg2 \
    curl \
 && rm -rf /var/lib/apt/lists/*

# This repo is used specifically to install the kubectl tool
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
 && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list \
 && apt-get update \
 && apt-get install -y \
    kubectl

COPY . /usr/local/bin/bookinfo-reboot

WORKDIR /usr/local/bin/bookinfo-reboot
CMD /usr/local/bin/bookinfo-reboot/bookinfo-reboot.sh
