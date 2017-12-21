FROM debian:9.2

LABEL maintainer "opsxcq@strm.sh"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git openssh-server sshpass \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --system --uid 666 -M --shell /usr/bin/git-shell git && \ 
    echo git:secret | chpasswd && \
    mkdir -p /home/git/.ssh && \
    mkdir /run/sshd && \
    chown -R git:git /home/git

COPY sshd.conf /etc/ssh/sshd_config
RUN mkdir /run/ssh

### Configure an empty git repository

WORKDIR /repo.git
RUN git init --bare && \
    chown git -R /repo.git

EXPOSE 22 

COPY main.sh /
ENTRYPOINT ["/main.sh"]

### Configure local key for healthcheck

WORKDIR /root/.ssh
RUN echo 'localhost '$(cat /etc/ssh/ssh_host_rsa_key.pub) >> known_hosts

COPY check.sh /
HEALTHCHECK --interval=10s --timeout=2s CMD /check.sh

