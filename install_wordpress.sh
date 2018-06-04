#!/bin/bash
wget http://wordpress.org/latest.tar.gz -O /var/www/html/$1/htdocs/wordpress.tar.gz
cd /var/www/html/$1/htdocs
tar xfz wordpress.tar.gz
mv wordpress/* ./
rmdir ./wordpress/
rm -f wordpress.tar.gz
cp wp-config-sample.php wp-config.php
perl -pi -e "s/database_name_here/$2/g" wp-config.php
perl -pi -e "s/username_here/$2/g" wp-config.php
perl -pi -e "s/password_here/$3/g" wp-config.php
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php
mkdir wp-content/uploads
chmod 775 wp-content/uploads
rm index.html
chown -R www-data:$2 . -R
chmod 771 . -R
