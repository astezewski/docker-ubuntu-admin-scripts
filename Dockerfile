FROM ubuntu:22.04

LABEL maintainer=""
LABEL description="Linux admin panel"

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    wget \
    vim \
    jq \
    iputils-ping \
    net-tools \
    dnsutils \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /scripts

COPY install/*.sh ./install/
COPY utils/*.sh ./utils/
COPY install/apps.txt ./install


RUN mkdir -p logs backup


RUN chmod -R +x .

CMD ["/bin/bash"]