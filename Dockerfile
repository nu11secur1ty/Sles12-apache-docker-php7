FROM opensuse:42.3
MAINTAINER venvaropt@gmail.com
ENV HOME /
RUN zypper -n update
RUN zypper -n install -y apache2 php7 php7-mysql apache2-mod_php7 mariadb mariadb-tools
RUN systemctl start apache2
RUN systemctl enable apache2
COPY /webapp/* /srv/www/htdocs/

