FROM opensuse/leap
MAINTAINER Phillip Shipley <venvaropt@gmail.com>

ENV REFRESHED_AT 2017-03-23
ENV HTTPD_PREFIX /etc/apache2

# install OS packages
RUN zypper update && zypper install -n \
    apache2 \
    curl \
    git \
    libapache2-mod-php \
    nano \
    netcat \
    php \
    php-cli \
    php-curl \
    php-dom \
    php-intl \
    php-json \
    php-ldap \
    php-mbstring \
    php-mcrypt \
    php-mysql \
    php-sqlite3 \
    php-gmp \
    php-zip \
    s3cmd \
    && phpenmod mcrypt \
    && zypper clean

# Install extra utils
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod a+x /usr/local/bin/composer \
    && composer global require fxp/composer-asset-plugin:^1.3.1 \
    && curl -o /usr/local/bin/whenavail https://bitbucket.org/silintl/docker-whenavail/raw/1.0.2/whenavail \
    && chmod a+x /usr/local/bin/whenavail

# Remove default site, configs, and mods not needed
WORKDIR $HTTPD_PREFIX
RUN rm -f \
    	sites-enabled/000-default.conf \
    	conf-enabled/serve-cgi-bin.conf \
    	mods-enabled/autoindex.conf \
    	mods-enabled/autoindex.load

# Enable additional configs and mods
RUN ln -s $HTTPD_PREFIX/mods-available/expires.load $HTTPD_PREFIX/mods-enabled/expires.load \
    && ln -s $HTTPD_PREFIX/mods-available/headers.load $HTTPD_PREFIX/mods-enabled/headers.load \
	&& ln -s $HTTPD_PREFIX/mods-available/rewrite.load $HTTPD_PREFIX/mods-enabled/rewrite.load

# Add our custom PHP ini files to the folders where they will be found.
COPY php-conf/*.ini /etc/php/7.0/apache2/conf.d/
COPY php-conf/*.ini /etc/php/7.0/cli/conf.d/

COPY vhost.conf /etc/apache2/sites-enabled/

EXPOSE 80

# By default, simply start apache.
CMD /usr/sbin/apache2ctl -D FOREGROUND



#FROM opensuse/leap
#MAINTAINER "Ventsislav Varbanovski <venvaropt@gmail.com>"

#RUN zypper --non-interactive --no-gpg-checks ref; \
#    zypper --non-interactive in --recommends \
#    apache2 php7 php7-mysql apache2-mod_php7 \
#    php7-gd php7-gettext php7-mbstring php7-pear php7-curl; \
#    zypper clean; \
#    sed -i 's/variables_order = "GPCS"/variables_order = "EGPCS"/g' /etc/php7/apache2/php.ini
    
COPY /webapp/* /srv/www/htdocs/

#CMD rcapache2 start && tail -f /var/log/apache2/*log


