FROM       openwrtorg/sdk:x86_64-19.07.7
MAINTAINER Viet Nguyen "<mrholao09@gmail.com>"

RUN sudo apt-get update

RUN sudo apt-get install -y openssh-server
RUN sudo mkdir /var/run/sshd

RUN sudo sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sudo sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN sudo mkdir /root/.ssh

RUN sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
