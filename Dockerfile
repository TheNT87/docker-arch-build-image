FROM pritunl/archlinux

ENV JAVA_VERSION=8u65 \
    JAVA_VERSION_PREFIX=1.8.0_65
ENV JAVA_HOME /opt/jre$JAVA_VERSION_PREFIX
ENV PATH $JAVA_HOME/bin:$PATH
RUN pacman -Syyu && \
    pacman --noconfirm --needed -S \
    openssh \
    sudo \
    procps \
    wget \
    unzip \
    mc \
    ca-certificates \
    curl && \
    mkdir /var/run/sshd && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,wheel -d /home/user --shell /bin/bash -m user && \
    sudo pacman -S --noconfirm git subversion && \
    paccache -r && \
    wget \
   --no-cookies \
   --no-check-certificate \
   --header "Cookie: oraclelicense=accept-securebackup-cookie" \
   -qO- \
   "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b17/jre-$JAVA_VERSION-linux-x64.tar.gz" | tar -zx -C /opt/ && \
    pacman -Syu && \
    echo "#! /bin/bash\n set -e\n sudo /usr/sbin/sshd -D &\n exec \"\$@\"" > /home/user/entrypoint.sh && chmod a+x /home/user/entrypoint.sh

    

#TODO dependencies
ENV LANG C.UTF-8
RUN echo "export JAVA_HOME=/opt/jre$JAVA_VERSION_PREFIX\nexport PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH" >> /home/user/.bashrc && \
    sudo locale-gen en_US.UTF-8


USER user

EXPOSE 22 4403
WORKDIR /projects
ENTRYPOINT ["/home/user/entrypoint.sh"]

CMD tail -f /dev/null
