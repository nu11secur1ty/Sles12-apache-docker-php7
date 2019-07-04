FROM opensuse/leap
MAINTAINER venvaropt@gmail.com

RUN zypper --non-interactive install -n apache2
RUN systemctl enable apache2
RUN a2enmod php7
RUN zypper --non-interactive install -n php7 php7-mysql apache2-mod_php7
RUN zypper --non-interactive install -n mariadb mariadb-tools
RUN systemctl enable mysql


COPY /webapp/* /srv/www/htdocs/
EXPOSE 80 

ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]
CMD rcmysql start

