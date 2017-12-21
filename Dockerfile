FROM debian:9.2

LABEL maintainer "opsxcq@strm.sh"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git openssh-server \
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

COPY main.sh /

EXPOSE 22 

ENTRYPOINT ["/main.sh"]

