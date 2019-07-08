FROM opensuse/leap
MAINTAINER venvaropt@gmail.com

# install apache2 using zypper
RUN zypper -n update && zypper -n install apache2
# start apache2 service
CMD ["apache2ctl", "-D FOREGROUND"]
# webapp
COPY /webapp/* /srv/www/htdocs/


