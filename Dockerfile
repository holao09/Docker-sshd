FROM       openwrtorg/sdk:x86_64-19.07.7
MAINTAINER Viet Nguyen "<mrholao09@gmail.com>"

RUN sudo apt-get update

RUN sudo apt-get install -y openssh-server

RUN sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
