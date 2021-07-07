FROM       openwrtorg/imagebuilder:ramips-mt7620-openwrt-21.02
MAINTAINER Viet Nguyen "<mrholao09@gmail.com>"

USER root:root

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

ADD authorized_keys  /root/.ssh

RUN sudo chown -R root:root /root 

RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

RUN rm -rf /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -q -N ""

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
