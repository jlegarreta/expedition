#!/bin/sh

if [[ -d /var/lib/mysql ]]; then
  if [[ ! -e /var/lib/mysql/ibdata1 ]]; then
    echo "Copying initial database files..."
    cp -a /var/lib/mysql.bak/* /var/lib/mysql
  fi
else
  mv /var/lib/mysql.bak /var/lib/mysql
fi

echo 'Starting all services for expedition...'

# Rsyslog
echo '* Starting rsyslogd...'
/usr/sbin/rsyslogd -i /var/run/rsyslogd.pid

# SSHD
echo '* Starting sshd...'
/usr/sbin/sshd -f /etc/ssh/sshd_config

# RabbitMQ
echo '* Starting rabbitmq...'
sudo -u rabbitmq -- rabbitmq-server -detached

# MySQL
echo '* Starting mysql...'
mysqld_safe --nowatch --datadir='/var/lib/mysql'
sleep 5

# Apache
echo '* Starting apache...'
apachectl start

# Generate /home/userSpace/environmentParameters.php
rm -f /home/userSpace/environmentParameters.php
sudo -u apache /bin/sh /var/www/html/OS/spark/scripts/getCPUs.sh

# Initialize ML settings
mysql -uroot -ppaloalto -e "INSERT INTO pandbRBAC.ml_settings(server) values('$(hostname -i)')"

# PanReadOrders 
echo '* Starting PanReadOrders...'
while ! nc -w 1 localhost 5672 </dev/null; do
  echo "waiting on rabbitmq..."
  sleep 2
done
sudo -u apache sh /var/www/html/OS/startup/pan-readOrders start
