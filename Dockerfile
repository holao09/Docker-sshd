FROM       openwrtorg/sdk:x86_64-19.07.7
MAINTAINER Viet Nguyen "<mrholao09@gmail.com>"

RUN sudo apt-get update

RUN sudo apt-get install -y openssh-server

ADD authorized_keys /home/build/.ssh
RUN chown -R build:build /home/build 
RUN chmod 700 /home/build/.ssh && chmod 600 /home/build/.ssh/authorized_keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -q -N ""

RUN sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
