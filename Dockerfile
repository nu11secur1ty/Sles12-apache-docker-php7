FROM opensuse/leap
MAINTAINER "Ventsislav Varbanovski <venvaropt@gmail.com>"
LABEL description="use this image to host your static web pages."
# Update OS
RUN zypper -n up
RUN zypper -n dup

# install apache2 using zypper
RUN zypper -n update && zypper -n install apache2

# install php7
RUN zypper -n update && zypper -n install php7 php7-mysql apache2-mod_php7

# Enamble php7_apache module
RUN a2enmod php7

# Installing of other software
RUN zypper install -y vim
RUN zypper install -y nmap
RUN zypper install -y net-tools-deprecated

# create welcome file for apache service
# RUN echo "Welcome to virtualapps/opensuse-apache2, copy your web pages to /srv/www/htdocs/" > /srv/www/htdocs/index.html 

COPY /webapp/* /srv/www/htdocs/

# start apache2 service
CMD ["apache2ctl", "-D FOREGROUND"]
