FROM opensuse:latest
MAINTAINER "Ventsislav Varbanovski <venvaropt@gmail.com>"
LABEL description="use this image to host your static web pages."

# install apache2 using zypper
RUN zypper -n update && zypper -n install apache2

# install php7
RUN zypper -n update && zypper -n install php7 php7-mysql apache2-mod_php7

# Enamble php7_apache module
RUN a2enmod php7 

# start apache2 service
CMD ["apache2ctl", "-D FOREGROUND"]
# webapp
COPY /webapp/* /srv/www/htdocs/


