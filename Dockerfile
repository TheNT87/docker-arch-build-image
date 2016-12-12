FROM pritunl/archlinux

RUN /usr/sbin/pacman -S git sudo --noconfirm --needed

RUN /usr/sbin/useradd -G wheel makepkg && /usr/sbin/passwd -d makepkg && /usr/sbin/gpasswd -a makepkg wheel
#RUN /usr/bin/echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/12-user.conf && chmod 660 /etc/sudoers.d/12-user.conf

ADD etc/sudoers /
RUN /usr/sbin/chown root:root /etc/sudoers && /usr/sbin/chmod 0600 /etc/sudoers

USER makepkg
