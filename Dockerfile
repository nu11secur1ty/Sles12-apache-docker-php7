FROM opensuse/leap
MAINTAINER venvaropt@gmail.com

RUN zypper --non-interactive install -n apache2
RUN systemctl enable apache2
RUN zypper --non-interactive install -n php7 php7-mysql apache2-mod_php7
RUN zypper --non-interactive install -n mariadb mariadb-tools
RUN systemctl enable mysql


COPY /webapp/* /srv/www/htdocs/
CMD rcapache2 start && tail -f /var/log/apache2/*log

