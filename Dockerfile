#!BuildTag: container
FROM opensuse/leap:42.3

# Define your additional repositories here
RUN zypper ar http://download.opensuse.org/repositories/openSUSE:Tools/openSUSE_Leap_42.3/ "openSUSE:Tools"
RUN zypper ref
# NOTE: the repositories from your project config are used by default

# Install further packages using zypper
RUN zypper install -y zypper in apache2 

RUN systemctl start apache2
RUN systemctl enable apache2

RUN zypper install -y php7 php7-mysql apache2-mod_php7
RUN a2enmod php7

RUN zypper install -y mariadb mariadb-tools
RUN systemctl start mysql


COPY /webapp/* /srv/www/htdocs/

CMD rcapache2 start && tail -f /var/log/apache2/*log
