#!/bin/bash

apt-get update
apt install apache2 -y
mv example.com.conf /etc/apache2/sites-available/
apt install mysql-server php-mysql -y
mysql_secure_installation
apt install php-common libapache2-mod-php php-cli -y
apt install php-pear php-mysql -y
apt-get install unzip php-mcrypt php-gd -y

mysql -uroot -p -e "update mysql.user set plugin=null where user='root';"
mysql -uroot -p -e "FLUSH PRIVILEGES";

apt-get install proftpd -y

a2enmod rewrite
a2dissite 000-default.conf
service apache2 restart

adduser ftpuser -shell /bin/false

cat <<EOT >> /etc/proftpd/proftpd.conf
<Global>
    RequireValidShell off
</Global>
DefaultRoot ~ ftpuser
<Limit LOGIN>
    DenyGroup !ftpuser
</Limit>
EOT
service proftpd restart
