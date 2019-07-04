#!BuildTag: container
FROM opensuse/leap:42.3

RUN zypper install -y zypper in apache2 

RUN systemctl start apache2
RUN systemctl enable apache2

RUN zypper install -y php7 php7-mysql apache2-mod_php7
RUN a2enmod php7

RUN zypper install -y mariadb mariadb-tools
RUN systemctl start mysql

COPY /webapp/* /srv/www/htdocs/

