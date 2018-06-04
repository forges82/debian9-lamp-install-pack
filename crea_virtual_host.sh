#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'ERROR. Pasa como parámetro el nombre del proyecto.'
    exit 1
fi
if [ -d "/var/www/html/$1" ] ; then
        echo 'ERROR. El proyecto ya existe. ¿Despublicar (d)?'
        read DESPUBLICAR
        if [[ "$DESPUBLICAR" = "d" ]]; then
                a2dissite $1.conf
                service apache2 reload
                echo 'Proyecto despublicado. Puedes proceder a borrar la base de datos y los archivos de $1'
        fi
        exit 1
fi
mkdir /var/www/html/$1/htdocs -p
echo '<h1>$1</h1>' > /var/www/html/$1/htdocs/index.html
mkdir /var/log/apache2/$1
cp /etc/apache2/sites-available/example.com.conf /etc/apache2/sites-available/$1.conf
sed -i -- "s/example.com/$1/g" /etc/apache2/sites-available/$1.conf
a2ensite $1.conf
service apache2 reload
