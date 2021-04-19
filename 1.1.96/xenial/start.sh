#!/bin/bash

set -euo pipefail

if [[ -d /var/lib/mysql ]]; then
  if [[ ! -e /var/lib/mysql/ibdata1 ]]; then
    echo "Copying initial database files..."
    cp -a /var/lib/mysql.bak/* /var/lib/mysql
  fi
else
  mv /var/lib/mysql.bak /var/lib/mysql
fi

# Fix ownership
chown -R mysql:mysql /var/lib/mysql
chown -R www-data:www-data /data

echo 'Starting all services for expedition...'

# Rsyslog
echo '* Starting rsyslogd...'
chown syslog:syslog /var/log
/etc/init.d/rsyslog start

# SSHD
echo '* Starting sshd...'
/etc/init.d/ssh start

# RabbitMQ
echo '* Starting rabbitmq...'
/etc/init.d/rabbitmq-server start

# MySQL
echo '* Starting mysql...'
/etc/init.d/mysql start
sleep 5

# Generate /home/userSpace/environmentParameters.php
rm -f /home/userSpace/environmentParameters.php
sudo -u www-data bash /var/www/html/OS/spark/scripts/getCPUs.sh
rm -f /var/run/apache2/httpd.pid

# Apache
echo '* Starting apache...'
apache2ctl start

# Initialize ML settings
mysql -uroot -ppaloalto <<-EOF
DELETE FROM pandbRBAC.ml_settings;
ALTER TABLE pandbRBAC.ml_settings AUTO_INCREMENT = 1;
INSERT INTO pandbRBAC.ml_settings(server) values('$(hostname -i)');
EOF

# PanReadOrders
echo '* Starting PanReadOrders...'
while ! nc -w 1 localhost 5672 </dev/null; do
  echo "waiting on rabbitmq..."
  sleep 2
done

/etc/init.d/panReadOrders start

tail -f /dev/null
