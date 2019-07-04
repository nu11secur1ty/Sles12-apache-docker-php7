FROM opensuse:42.3
MAINTAINER venvaropt@gmail.com
ENV HOME /
RUN zypper -n update
RUN zypper -n install -y apache2 php7 php7-mysql apache2-mod_php7 mariadb mariadb-tools
RUN systemctl start apache2
RUN systemctl enable apache2
RUN zypper --no-gpg-checks -n -p http://download.opensuse.org/repositories/devel:/tools/openSUSE_Leap_42.3/ install rpmdevtools
RUN rpmdev-setuptree
ADD ./rpmbuild/ /rpmbuild/
RUN chown -R root:root /rpmbuild
RUN rpmbuild -ba /rpmbuild/SPECS/h2o.spec
RUN tar -czf /tmp/h2o.tar.gz -C /rpmbuild RPMS SRPMS
CMD ["/bin/true"]

COPY /webapp/* /srv/www/htdocs/

