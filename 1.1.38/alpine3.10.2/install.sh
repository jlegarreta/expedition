#!/bin/sh
set -e

echo 'Installing dependencies...'
apk --no-cache update
apk add --no-cache apache2 apache2-ctl apache2-ssl bash binutils coreutils curl libxml2 libxslt mariadb mariadb-client musl openjdk8-jre openssh-server openssl perl perl-list-moreutils php7 php7-apache2 php7-bcmath php7-bz2 php7-curl php7-gd php7-iconv php7-ldap php7-mbstring php7-mcrypt php7-mysqli php7-opcache php7-pdo php7-pdo_mysql php7-session php7-soap php7-xml php7-zip procps python3 rsyslog subversion util-linux zip zlib py3-lxml py3-unidecode py3-six py3-sqlalchemy sudo py3-yaml py3-jinja2 py3-xlsxwriter py3-requests netcat-openbsd diffutils openssh-client php7-json php7-simplexml tzdata 
apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing py3-pandas policycoreutils rabbitmq-server time

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
