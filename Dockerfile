FROM opensuse/leap
MAINTAINER "Ventsislav Varbanovski <venvaropt@gmail.com>"

RUN zypper --non-interactive --no-gpg-checks ref; \
    zypper --non-interactive in --recommends \
    apache2 php7 php7-mysql apache2-mod_php7 \
    php7-gd php7-gettext php7-mbstring php7-pear php7-curl; \
    zypper clean; \
    sed -i 's/variables_order = "GPCS"/variables_order = "EGPCS"/g' /etc/php7/apache2/php.ini
    
COPY /webapp/* /srv/www/htdocs/

CMD rcapache2 start && tail -f /var/log/apache2/*log


