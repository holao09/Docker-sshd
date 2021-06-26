FROM       openwrtorg/sdk:x86_64-19.07.7
MAINTAINER Viet Nguyen "<mrholao09@gmail.com>"

RUN sudo apt-get update

RUN sudo apt-get install -y openssh-server

RUN adduser -g "User" -D holao09 && mkdir -p /home/holao09/.ssh

RUN echo "holao09:holao09" | chpasswd

ADD authorized_keys /home/holao09/.ssh
RUN chown -R holao09:holao09 /home/holao09 
RUN chmod 700 /home/holao09/.ssh && chmod 600 /home/holao09/.ssh/authorized_keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -q -N ""


RUN sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
