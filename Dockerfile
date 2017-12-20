FROM debian:9.2

LABEL maintainer "opsxcq@strm.sh"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git openssh-server \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 22 

COPY sshd.conf /etc/ssh/sshd_config

VOLUME /data
WORKDIR /data

ENTRYPOINT ["sshd"]
CMD ["default"]

