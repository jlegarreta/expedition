#!/bin/bash

set -xeuo pipefail

currentwd="$(pwd)"
interactive=

# Configure variables
declare_variables() {
  #user=$(echo "$USER")
  #sourcePath=/PALogs/PaloAltoSC2
  #TrafficRotatorPath=/var/www/html/OS/trafficRotator/prepareTrafficLog.sh
  #deviceDeclarationPath=/var/www/html/OS/trafficRotator/devices.txt

  bold=$(tput bold)
  normal=$(tput sgr0)
  #BLACK=$(tput setaf 0)
  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  #YELLOW=$(tput setaf 3)
  BLUE=$(tput setaf 4)
  #MAGENTA=$(tput setaf 5)
  #CYAN=$(tput setaf 6)
  #WHITE=$(tput setaf 7)
}

printBanner() {
  echo ""
  echo "${GREEN}${bold}************************************************************"
  echo "$1"
  echo "************************************************************${normal}"
}

printTitleWait() {
  if [[ $interactive -eq 1 ]]; then
    echo ""
    echo "${GREEN}"
    echo "$1"
    read -p -r "${BLUE}Press enter to continue${normal}"

  else
    echo ""
    echo "${GREEN}"
    echo "$1"
    echo "${normal}"
  fi
}

printTitle() {
  echo "${GREEN}"
  echo "$1"
  echo "${normal}"
}

printTitleFailed() {
  echo "${RED}"
  echo "$1"
  echo "${normal}"
}

updateRepositories() {
  printTitle "Updating APT"
  apt-get update
  apt-get install -y software-properties-common
  printTitle "Installing Expect"
  apt-get install -y expect
  printTitle "Installing RSyslog debian repository"
  expect -c "
        set timeout 60
        spawn add-apt-repository ppa:adiscon/v8-stable
        expect -re \"Press *\" {
            send -- \"\r\"
            exp_continue
        }
    "

  printTitle "Installing Expedition debian repository"
  echo 'deb [trusted=yes] https://conversionupdates.paloaltonetworks.com/ expedition-updates/' >/etc/apt/sources.list.d/ex-repo.list

  printTitle "Installing MariaDB debian repository"
  apt-get -y install software-properties-common gnupg-curl
  apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
  add-apt-repository 'deb [arch=amd64,arm64,i386,ppc64el] http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu xenial main'

  apt-get update
}

prepareSystemService() {
  #vi /etc/ssh/sshd_config

  printTitleWait "Changing CLI root password to 'paloalto'"
  echo -e "paloalto\npaloalto" | passwd root

  printTitleWait "Installing SSHD service"
  apt-get install -y openssh-server

  printTitle "Enabling ROOT ssh access"
  filePath=/etc/ssh/sshd_config
  sed -i '/^ *PermitRootLogin/ s/.*/PermitRootLogin yes/g' "${filePath}"
  /etc/init.d/ssh restart

  # Add ZIP and Zlib
  printTitle "Installing ZIP libraries"
  apt-get install -y zip
  apt-get install -y zlib1g-dev

  # Rsyslog
  printTitleWait "Installing Rsyslog for syslog Firewall traffic logs"
  apt-get install -y rsyslog
  /etc/init.d/rsyslog start

  cp /lib/systemd/system/rsyslog.service /etc/systemd/system/rsyslog.service
  # vi /lib/systemd/system/rsyslog.service
  # [Service]
  # Type=notify
  # ExecStart=/usr/sbin/rsyslogd -n
  #  StandardOutput=null
  #  Restart=on-failure

  #update-rc.d rsyslog enable
  #systemctl enable rsyslog.service
}

installLAMP() {
  # Install all Apache required modules
  printTitleWait "Installing Apache service and dependencies for PHP"
  apt-get install -y apache2 \
    php7.0 libapache2-mod-php7.0 \
    php7.0-bcmath php7.0-mbstring php7.0-gd php7.0-soap php7.0-zip php7.0-xml php7.0-opcache php7.0-curl php7.0-bz2 php7.0-mcrypt \
    php7.0-ldap \
    php7.0-mysql

  # Install openssl for https
  printTitle "Activating SSL on Apache"
  apt-get install -y openssl
  # Enable SSL for the Web Server
  a2ensite default-ssl
  a2enmod ssl
  apache2ctl restart

  # Database Server
  printTitleWait "Installing the DB server. " # Please, do not enter a password for root. We will automatically update it later to 'paloalto'.Remember: DO NOT ENTER A PASSWORD"
  # printTitleWait "Let us emphasize it: DO NOT ENTER A PASSWORD"
  expect -c "
        set timeout 600
        spawn apt-get install -y mariadb-server mariadb-client
        expect -re \"New password for the MariaDB *\" {
            send \"\r\"
            exp_continue
        }
    "

  mysql_install_db
  /etc/init.d/mysql start
  sleep 5

  echo 'update mysql.user set plugin="" where User="root"; flush privileges; ' | mysql -uroot

  # Install the secure controls for MySQL
  # Make sure that NOBODY can access the server without a password. Password changes to "paloalto"
  mysql -e "UPDATE mysql.user SET Password = PASSWORD('paloalto') WHERE User = 'root'"
  # Kill the anonymous users
  #mysql -e "DROP USER ''@'localhost'"
  # Because our hostname varies we'll use some Bash magic here.
  #mysql -e "DROP USER ''@'$(hostname)'"
  # Kill off the demo database
  #mysql -e "DROP DATABASE test"
  # Make our changes take effect
  mysql -e "FLUSH PRIVILEGES"
  # Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

  filePath=/etc/mysql/my.cnf
  sed -i 's/max_allowed_packet\t= 16M/max_allowed_packet\t= 64M/g' $filePath
  sed -i 's/bind-address\t\t= 127.0.0.1/#bind-address\t\t= 127.0.0.1/g' $filePath
  sed -i 's/#binlog_format=row/binlog_format=mixed/g' $filePath
  service mysql restart
  sleep 5

  # Create Databases
  printTitle "Creating initial Databases"
  mysqladmin -uroot -ppaloalto create pandb
  mysqladmin -uroot -ppaloalto create pandbRBAC
  mysqladmin -uroot -ppaloalto create BestPractices
  mysqladmin -uroot -ppaloalto create RealTimeUpdates

  # PERL
  printTitleWait "Installing Perl"
  apt-get install -y perl
  apt-get install -y liblist-moreutils-perl

  printTitleWait "Installing Python dependencies for BPA modules"
  curl -skL https://bootstrap.pypa.io/pip/3.5/get-pip.py >/tmp/get-pip.py
  python3 /tmp/get-pip.py
  pip3 install lxml
  pip3 install --upgrade pip
  pip3 install unidecode
  pip3 install pandas
  pip3 install six
  pip3 install sqlalchemy

  # RabbitMQ
  printTitleWait "Installing Messaging system for background tasks"
  apt-get install -y rabbitmq-server
  update-rc.d rabbitmq-server defaults
  apt-get install -y policycoreutils

  #Add www-data to expedition group
  usermod -a -G expedition www-data
}

installExpeditionPackages() {
  # apt-get Repository
  printTitleWait "Installing Expedition packages"

  printTitle "Updating databases"
  cd "$currentwd" || exit
  mysql -uroot -ppaloalto pandb <databases/pandb.sql
  mysql -uroot -ppaloalto pandbRBAC <databases/pandbRBAC.sql
  mysql -uroot -ppaloalto BestPractices <databases/BestPractices.sql
  mysql -uroot -ppaloalto RealTimeUpdates <databases/RealTimeUpdates.sql

  /etc/init.d/rabbitmq-server start

  # Installing Expedition package
  apt-get install -y --allow-unauthenticated expedition-beta

  printTitle "Tunning some Expedition parameters"
  filePath=/etc/mysql/my.cnf
  sed -i 's/log_bin/skip-log_bin/g' $filePath

  filePath=/etc/php/7.0/apache2/php.ini
  sed -i 's/mysqli.reconnect = Off/mysqli.reconnect = On/g' $filePath
  filePath=/etc/php/7.0/cli/php.ini
  sed -i 's/mysqli.reconnect = Off/mysqli.reconnect = On/g' $filePath
  apache2ctl restart

  printTitle "Updating Python modules"
  bash /var/www/html/OS/BPA/updateBPA306.sh

  printTitle "Installing Spark dependencies"
  apt-get install -y openjdk-8-jre-headless
  apt-get install -y --allow-unauthenticated expeditionml-dependencies-beta

  cp /var/www/html/OS/spark/config/log4j.properties /opt/Spark/
  rm -f /home/userSpace/environmentParameters.php

}

settingUpFirewallSettings() {
  printTitle "Installing Firewall service"
  apt-get install -y firewalld

  printTitle "Firewall rules for Web-browsing"
  #APACHE2
  firewall-cmd --add-port=443/tcp
  firewall-cmd --permanent --add-port=443/tcp

  printTitle "Firewall rules for Database (skipped)"
  #MySQL/MariaDB (optional)
  #firewall-cmd --add-port=3306/tcp
  #firewall-cmd --permanent --add-port=3306/tcp

  #RabbitMQ

  #SPARK
  printTitle "Firewall rules for ML Web-Interfaces"
  firewall-cmd --add-port=4050-4070/tcp
  firewall-cmd --permanent --add-port=4050-4070/tcp

  firewall-cmd --add-port=5050-5070/tcp
  firewall-cmd --permanent --add-port=5050-5070/tcp
}

createExpeditionUser() {
  exists=$(id -u expedition | wc -l)
  if [ "$exists" -eq 1 ]; then
    printTitle "Expedition user already exists"
  else
    printTitleFailed "expedition user does not exist"
    printTitleFailed "Create expedition user via \"adduser --gecos '' expedition\""
    printTitleFailed "Execute this installer again afterwards"
    exit 1
  fi
}

createPanReadOrdersService() {
  cp /var/www/html/OS/startup/panReadOrdersStarter /etc/init.d/panReadOrders
  chmod 755 /etc/init.d/panReadOrders
  chown root:root /etc/init.d/panReadOrders
  ln -s /etc/init.d/panReadOrders /etc/rc2.d/S99panReadOrders
  ln -s /etc/init.d/panReadOrders /etc/rc3.d/S99panReadOrders
  ln -s /etc/init.d/panReadOrders /etc/rc4.d/S99panReadOrders
  ln -s /etc/init.d/panReadOrders /etc/rc5.d/S99panReadOrders

  /etc/init.d/panReadOrders start
}

controlVersion() {
  ubuntuVersion=$(lsb_release -a | grep Release | awk '{print $2}')
  if [ "$ubuntuVersion" == "16.04" ]; then
    printTitle "Correct Ubuntu Server 16.04 version"
  else
    printTitleFailed "This script has been prepared for Ubuntu Server 16.04"
    printTitleFailed "Current version: "
    echo "$ubuntuVersion"
    exit 1
  fi

  # Check if some packages has already been installed
  expeditionAlreadyInstalled=$(apt list --installed | grep -c expedition-beta || true)
  if [ "$expeditionAlreadyInstalled" -ne 0 ]; then
    printTitleFailed "This script has been prepared to install Expedition from scratch"
    printTitleFailed "Expedition package is already present"
    exit 1
  else
    printTitle "This machine does not have Expedition installed"
  fi

}

updateSettings() {
  # myIP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
  myIP=$(hostname -I)
  echo "INSERT INTO ml_settings (server) VALUES ('${myIP}') " | mysql -uroot -ppaloalto pandbRBAC
}

introduction() {
  echo
  echo "${GREEN}   ****************************************************************************************"
  echo "   *                                                                                      *"
  echo "   *              WELCOME TO EXPEDITION ASSISTED INSTALLER v.0.3 (10/24/2019)             *"
  echo "   *                                                                                      *"
  echo "   *  This script will download and install required packages to prepare Expedition on    *"
  echo "   *  Ubuntu server 16.04. A ${bold}NEW image${normal}${GREEN} is expected for this installer to take effect.     *"
  echo "   *  This installer requires ${bold}Internet Connection${normal}${GREEN}                                         *"
  echo "   *                                                                                      *"
  echo "   *                                                                                      *"
  echo "   *  We do not take any responsibility and we are not liable for any damage caused       *"
  echo "   *  through use of this tool, be it indirect, special, incidental or consequential      *"
  echo "   *  damages (including but not limited to damages for loss of business, loss of pro-    *"
  echo "   *  fits, interruption or the like). If you have any questions regarding the terms of   *"
  echo "   *  use outlined here, please do not hesitate to contact us at                          *"
  echo "   *                fwmigrate@paloaltonetworks.com                                        *"
  echo "   *                                                                                      *"
  echo "   *  If you continue with this installation you acknowledge having read the above lines  *"
  echo "   *                                                                                      *"
  echo "   ****************************************************************************************${normal}"
  printTitleWait ""

}

usage() {
  echo "usage: initSetup [-i] | [-h]"
}

# Establish run order
main() {

  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
    -i | --interactive)
      interactive=1
      ;;
    -h | --help)
      usage
      exit
      ;;
    *)
      usage
      exit 1
      ;;
    esac
    shift
  done

  declare_variables

  introduction

  controlVersion

  createExpeditionUser

  printBanner "Updating Debian Repositories"
  #apt-get -y install expect
  updateRepositories # Update Debian repositories

  # Prepare userSpace for Expedition data storage
  printTitle "Preparing the /home/userSpace Space for data storage"
  mkdir -p /home/userSpace
  chown www-data:www-data -R /home/userSpace
  mkdir -p /data
  chown www-data:www-data -R /data

  printBanner "Installing System Services"
  prepareSystemService # Allow remote root ssh access. Change PermitRootLogin prohibit-password to PermitRootLogin yes

  printBanner "Installing LAMP Services"
  installLAMP

  printBanner "Installing Expedition packages"
  installExpeditionPackages

  printBanner "Starting Task Manager"
  createPanReadOrdersService

  updateSettings

  # Stop services
  apache2ctl stop
  /etc/init.d/ssh stop
  pgrep -f "readOrders.php" | xargs kill
  /etc/init.d/rabbitmq-server stop
  /etc/init.d/mysql stop
  /etc/init.d/rsyslog stop

  sync
  sleep 3
  sync

  # Backup MySQL files
  mv /var/lib/mysql /var/lib/mysql.bak

  # Patches
  sed -i 's/pip show best-practice-assessment-ngfw-pano/pip show BPA/g' /var/www/html/libs/settings/PackageVersionChecker.php
  chown www-data:www-data /var/www
  touch /var/log/{auth.log,kern.log,rsyslog.log,syslog}
  chown syslog:syslog /var/log/{auth.log,kern.log,rsyslog.log,syslog}
  apt-mark hold libmariadbclient18 libmysqlclient18

  echo "Installation complete!"
}

main "$@"
