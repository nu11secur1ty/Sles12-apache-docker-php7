FROM opensuse/leap
MAINTAINER "Ventsislav Varbanovski <venvaropt@gmail.com>"

# The ADD command adds files from your directory into the new image
#ADD *.repo /etc/zypp/repos.d/
#ADD *.service /etc/zypp/services.d

RUN zypper refs && zypper refresh
#ADD index.html /srv/www/htdocs/
#CMD     /usr/sbin/apachectl -D FOREGROUND
#EXPOSE  80

#FROM opensuse/leap
#MAINTAINER venvaropt@gmail.com

# install apache2 and php7 using zypper
RUN     zypper  --non-interactive in apache2 \
        apache2-mod_php7 php7 php7-mysql 

# install apache2 using zypper
RUN zypper -n update && zypper -n install apache2

# start apache2 service
CMD ["apache2ctl", "-D FOREGROUND"]
# webapp
COPY /webapp/* /srv/www/htdocs/


