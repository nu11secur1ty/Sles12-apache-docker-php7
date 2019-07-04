FROM opensuse:42.3
MAINTAINER venvaropt@gmail.com
 
RUN zypper in apache2
RUN systemctl start apache2
RUN systemctl enable apache2
RUN zypper in php7 php7-mysql apache2-mod_php7
RUN a2enmod php7
RUN systemctl restart apache2
RUN zypper in mariadb mariadb-tools
RUN systemctl start mysql
RUN  systemctl enable mysql

 
COPY /webapp/* /srv/www/htdocs/
CMD rcapache2 start && tail -f /var/log/apache2/*log
