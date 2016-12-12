FROM pritunl/archlinux
RUN /usr/sbin/useradd -G wheel makepkg && /usr/sbin/passwd -d makepkg
USER makepkg
CMD /usr/sbin/pacman -Ql