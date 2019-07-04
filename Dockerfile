FROM opensuse/leap
MAINTAINER venvaropt@gmail.com

# install apache2 using zypper
RUN zypper -n update && zypper -n install apache2

# start apache2 service
CMD ["apache2ctl", "-D FOREGROUND"]
# webapp
COPY /webapp/* /srv/www/htdocs/

RUN zypper -n update && zypper --non-interactive -n php7 php7-mysql apache2-mod_php7
RUN zypper -n update && zypper --non-interactive -n mariadb mariadb-tools
RUN a2enmod php7

RUN systemctl enable mysql
CMD rcmysql start

