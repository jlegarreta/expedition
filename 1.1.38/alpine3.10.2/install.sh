#!/bin/sh
set -e

echo 'Installing dependencies...'
apk --no-cache update
# apk add --no-cache apache2=2.4.41-r0 apache2-ctl=2.4.41-r0 apache2-ssl=2.4.41-r0 bash=5.0.0-r0 coreutils=8.31-r0 curl=7.66.0-r0 cython3=0.29.10-r0 g++=8.3.0-r0 gfortran=8.3.0-r0 libxml2-dev=2.9.9-r2 libxslt-dev=1.1.33-r1 mariadb=10.3.17-r0 mariadb-client=10.3.17-r0 musl-dev=1.1.22-r3 openjdk8-jre=8.212.04-r1 openssh-server=8.0_p1-r0 openssl=1.1.1d-r0 perl=5.28.2-r1 perl-list-moreutils=0.428-r0 php7=7.3.9-r0 php7-apache2=7.3.9-r0 php7-bcmath=7.3.9-r0 php7-bz2=7.3.9-r0 php7-curl=7.3.9-r0 php7-gd=7.3.9-r0 php7-iconv=7.3.9-r0 php7-ldap=7.3.9-r0 php7-mbstring=7.3.9-r0 php7-mcrypt=1.0.2-r1 php7-mysqli=7.3.9-r0 php7-opcache=7.3.9-r0 php7-pdo=7.3.9-r0 php7-pdo_mysql=7.3.9-r0 php7-session=7.3.9-r0 php7-soap=7.3.9-r0 php7-xml=7.3.9-r0 php7-zip=7.3.9-r0 procps=3.3.15-r0 py-numpy-dev=1.16.4-r1 py3-numpy=1.16.4-r1 python3-dev=3.7.3-r0 rsyslog=8.1904.0-r0 subversion=1.12.2-r0 util-linux=2.33.2-r0 zip=3.0-r7 zlib-dev=1.2.11-r1 py3-lxml=4.3.4-r0 py3-unidecode=1.0.23-r1 py3-six=1.12.0-r1 py3-sqlalchemy=1.3.2-r1 sudo=1.8.27-r0 py3-yaml=5.1.1-r0 py3-jinja2=2.10-r3 py3-xlsxwriter=1.1.8-r1 py3-requests=2.21.0-r4 netcat-openbsd=1.130-r1 diffutils=3.7-r0 openssh-client=8.0_p1-r0 php7-json=7.3.9-r0 php7-simplexml=7.3.9-r0 tzdata=2019b-r0
apk add --no-cache apache2=2.4.41-r0 apache2-ctl=2.4.41-r0 apache2-ssl=2.4.41-r0 bash=5.0.0-r0 binutils=2.32-r0 coreutils=8.31-r0 curl=7.66.0-r0 libxml2=2.9.9-r2 libxslt=1.1.33-r1 mariadb=10.3.17-r0 mariadb-client=10.3.17-r0 musl=1.1.22-r3 openjdk8-jre=8.212.04-r1 openssh-server=8.0_p1-r0 openssl=1.1.1d-r0 perl=5.28.2-r1 perl-list-moreutils=0.428-r0 php7=7.3.9-r0 php7-apache2=7.3.9-r0 php7-bcmath=7.3.9-r0 php7-bz2=7.3.9-r0 php7-curl=7.3.9-r0 php7-gd=7.3.9-r0 php7-iconv=7.3.9-r0 php7-ldap=7.3.9-r0 php7-mbstring=7.3.9-r0 php7-mcrypt=1.0.2-r1 php7-mysqli=7.3.9-r0 php7-opcache=7.3.9-r0 php7-pdo=7.3.9-r0 php7-pdo_mysql=7.3.9-r0 php7-session=7.3.9-r0 php7-soap=7.3.9-r0 php7-xml=7.3.9-r0 php7-zip=7.3.9-r0 procps=3.3.15-r0 python3=3.7.3-r0 rsyslog=8.1904.0-r0 subversion=1.12.2-r0 util-linux=2.33.2-r0 zip=3.0-r7 zlib=1.2.11-r1 py3-lxml=4.3.4-r0 py3-unidecode=1.0.23-r1 py3-six=1.12.0-r1 py3-sqlalchemy=1.3.2-r1 sudo=1.8.27-r0 py3-yaml=5.1.1-r0 py3-jinja2=2.10-r3 py3-xlsxwriter=1.1.8-r1 py3-requests=2.21.0-r4 netcat-openbsd=1.130-r1 diffutils=3.7-r0 openssh-client=8.0_p1-r0 php7-json=7.3.9-r0 php7-simplexml=7.3.9-r0 tzdata=2019b-r0
apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing rabbitmq-server=3.7.18-r0 policycoreutils=2.8-r0 time=1.9-r0 py3-pandas=0.25.1-r0

echo 'Creating expedition user...'
adduser -D expedition

echo 'Preparing userSpace and data directories...'
mkdir -p /home/userSpace /data
chown -R apache:apache /home/userSpace /data

echo 'Starting rsyslogd...'
/usr/sbin/rsyslogd -i /var/run/rsyslogd.pid

echo 'Preparing SSH service (for Machine Learning)...'
ssh-keygen -A
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
/usr/sbin/sshd -f /etc/ssh/sshd_config
echo "root:paloalto" | chpasswd

echo 'Preparing database...'
cp /usr/share/zoneinfo/Etc/UTC /etc/localtime
cat mariadb-server.cnf > /etc/my.cnf.d/mariadb-server.cnf
mysql_install_db --user=mysql --datadir=/var/lib/mysql
mysqld_safe --nowatch --datadir='/var/lib/mysql'
sleep 5
mysqladmin create pandb
mysqladmin create pandbRBAC
mysqladmin create BestPractices
mysqladmin create RealTimeUpdates
mysql -uroot <<EOF
TRUNCATE TABLE mysql.user;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'paloalto' WITH GRANT OPTION;
UPDATE mysql.user SET plugin="" WHERE User="root";
FLUSH PRIVILEGES;
EOF

echo 'Installing Python dependencies for BPA modules...'
#pip3 install -U pip
#pip3 install pandas==0.25.1

echo 'Preparing rabbitmq...'
chown -R rabbitmq:rabbitmq /usr/lib/rabbitmq
sudo -u rabbitmq -- rabbitmq-server -detached

echo 'Installing Expedition packages...'

echo '* Updating databases...'
# tar -xf databases.tgz
mysql -uroot -ppaloalto pandb < databases/pandb.sql
mysql -uroot -ppaloalto pandbRBAC < databases/pandbRBAC.sql
mysql -uroot -ppaloalto BestPractices < databases/BestPractices.sql
mysql -uroot -ppaloalto RealTimeUpdates < databases/RealTimeUpdates.sql

echo '* Tuning PHP parameters...'
sed -i 's/mysqli.reconnect = Off/mysqli.reconnect = On/g' /etc/php7/php.ini

echo '* Installing expedition-beta package...'
# expedition-beta package
rm -rf /var/www/localhost/htdocs
mv var/www/html /var/www/
chown -R root:root /var/www/html
ln -s /var/www/html /var/www/localhost/htdocs

# Post-install tasks for expedition-beta package
apachectl start
pip3 install --upgrade pip > /tmp/expedition-update
pip3 install --upgrade pip >> /tmp/expedition-update
pip3 install pandevice >> /tmp/expedition-update
/usr/bin/php /var/www/html/bin/updates/updateSQL.php
sudo -u apache /bin/sh /var/www/html/OS/startup/pan-readOrders restart >> /tmp/expedition-update
sudo -u apache /usr/bin/php /var/www/html/OS/update/snsUpdate.php
rm -f /var/www/html/OS/update/snsUpdate.php
echo "* Checking for old projects and Devices what are not Encrypted"
sudo -u apache /usr/bin/php /var/www/html/libs/Security/checkSecurity.php
pip3 install /var/www/html/OS/BPA/best_practice_assessment_ngfw_pano-master.zip --upgrade >> /tmp/expedition-update

echo '* Installing Palo Alto BPA (Best Practice Asessment)...'
pip3 uninstall best-practice-assessment-ngfw-pano -y
ln -s /usr/bin/python3.7 /usr/bin/python3.6
pip3 install /var/www/html/OS/BPA/best_practice_assessment_ngfw_pano-master.zip --upgrade

echo 'Installing Spark (for Machine Learning)...'
mv opt/Spark /opt
/opt/Spark/postScripts/unpackPackages.sh
cp -af /var/www/html/OS/spark/config/log4j.properties /opt/Spark/log4j.properties

echo 'Remediating known issues...'
mkdir /boot
sed -i "s/define ('DBSQL_LOG_BIN', 1);/define ('DBSQL_LOG_BIN', 0);/g" /home/userSpace/userDefinitions.php

echo 'Cleaning up...'
mysqladmin -uroot -ppaloalto shutdown
mv /var/lib/mysql /var/lib/mysql.bak
rm -rf databases var opt install.sh mariadb-server.cnf
set +e
find / -type f 2>/dev/null | xargs strip -s 2>/dev/null
find / 2>/dev/null | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

echo 'Installation complete!'
