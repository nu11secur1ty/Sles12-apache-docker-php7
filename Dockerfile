FROM opensuse/leap
MAINTAINER venvaropt@gmail.com

RUN zypper --non-interactive --no-gpg-checks ref; \
    zypper --non-interactive in --recommends \
    apache2 \ 
    php7 php7-mysql apache2-mod_php7 \
    mariadb mariadb-tools; \
    zypper clean; \
    
RUN systemctl start apache2
RUN systemctl enable apache2
RUN a2enmod php7
RUN systemctl restart apache2
RUN systemctl start mysql
RUN systemctl enable mysql
  
    
COPY /webapp/* /srv/www/htdocs/

CMD rcapache2 start && tail -f /var/log/apache2/*log
