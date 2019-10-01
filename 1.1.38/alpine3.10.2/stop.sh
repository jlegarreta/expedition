#!/bin/sh

echo 'Stopping all services for expedition...'

# Rsyslog
echo '* Stopping rsyslogd...'
kill $(cat /var/run/rsyslogd.pid)

# SSHD
echo '* Stopping sshd...'
kill $(cat /var/run/sshd.pid)

# RabbitMQ
echo '* Stopping rabbitmq...'
sudo -u rabbitmq -- rabbitmqctl stop

# MySQL
echo '* Stopping mysql...'
mysqladmin -uroot -ppaloalto shutdown

# Apache
echo '* Stopping apache...'
apachectl stop

# PanReadOrders
echo '* Stopping PanReadOrders...'
sudo -u apache sh /var/www/html/OS/startup/pan-readOrders stop
