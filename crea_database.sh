#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'ERROR. Pasa como primer parámetro el nombre de la bd y user.'
    exit 1
fi
if [[ $# -eq 1 ]] ; then
    echo 'ERROR. Pasa como segundo parámetro el pass del user de la bd.'
    exit 1
fi
if [[ $# -eq 2 ]] ; then
    echo 'ERROR. Pasa como tercer parámetro el dominio.'
    exit 1
fi

mysql -uroot -p -e "CREATE DATABASE $1;"
mysql -uroot -p -e "CREATE USER '$1'@'localhost' IDENTIFIED BY '$2';"
mysql -uroot -p -e "GRANT ALL PRIVILEGES ON $1.* TO '$1'@'localhost';"
mysql -uroot -p -e "FLUSH PRIVILEGES";
echo 'Base de Datos: $1'
echo 'Usuario: $1'
echo 'Pass: $2'
adduser $1 -shell /bin/false -home /var/www/html/$3
adduser $1 ftpuser
adduser $1 www-data
adduser www-data $1
chown -hR www-data:$1 /var/www/html/$3
