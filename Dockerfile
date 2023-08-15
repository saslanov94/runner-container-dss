FROM ubuntu:22.04

USER root
WORKDIR /root

RUN apt update -y && apt upgrade -y &&\
        DEBIAN_FRONTEND=noninteractive apt-get -qq -y install --no-install-recommends \
        wget \
        curl \
        git \
        gpg-agent \
        make \
        sudo \
        bash-completion \
        tree \
        vim \
        tar \
        software-properties-common && \
        add-apt-repository ppa:deadsnakes/ppa -y &&\
        apt-get update -y &&\
        DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
        python3.10 \
        python3-pip

COPY requirements.txt /root/requirements.txt

RUN python3 -m pip install --upgrade pip &&\
    python3 -m pip install -r requirements.txt &&\
    export SED_RANGE="$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+1)),$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+7))" && \
    sed -i -e "${SED_RANGE}"' s/^#//' /etc/bash.bashrc && \
    unset SED_RANGE

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN add-apt-repository -y ppa:git-core/ppa && \
    apt-get update && \
    apt-get -y install --no-install-recommends git=1:2.41.0-0ppa1~ubuntu22.04.1 && \
    apt-get -y clean && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    groupadd -g 121 runner && useradd -mr -d /home/runner -u 1001 -g 121 runner &&\
    echo "runner ALL= EXEC: NOPASSWD:ALL" >> /etc/sudoers.d/runner

WORKDIR /home/runner
ENV HOME /home/runner
ENV USER runner

USER runner

CMD [ "/bin/bash" ]