FROM opensuse:latest
MAINTAINER venvaropt@gmail.com

ENV container docker

RUN zypper -n install systemd; zypper clean ; \
(cd /usr/lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /usr/lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /usr/lib/systemd/system/local-fs.target.wants/*; \
rm -f /usr/lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /usr/lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /usr/lib/systemd/system/basic.target.wants/*;\
rm -f /usr/lib/systemd/system/anaconda.target.wants/*;
zypper --non-interactive --no-gpg-checks ref; \
zypper --non-interactive in --recommends \
apache2 php7 php7-mysql apache2-mod_php7 \
a2enmod php7 \
zypper clean; \
sed -i 's/variables_order = "GPCS"/variables_order = "EGPCS"/g' /etc/php7/apache2/php.ini
    
COPY /webapp/* /srv/www/htdocs/

CMD rcapache2 start && tail -f /var/log/apache2/*log

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/lib/systemd/systemd", "--system"]
