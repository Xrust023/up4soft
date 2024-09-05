#!bin/bash

sudo apt update
sudo apt install nginx -y
sudo apt install php-fpm php-mysql php-pgsql php-xml php-mbstring php-curl php-zip php-gd -y

# Установка Wordpress
sudo wget https://wordpress.org/latest.tar.gz
sudo rm -rf /var/www/html/wordpress
sudo mkdir /var/www/html/wordpress
sudo tar -xzvf latest.tar.gz
sudo mv wordpress/* /var/www/html/wordpress
sudo rm -rf latest.tar.gz

# Установка конфигурации для PostgreSql
sudo git clone https://github.com/kevinoid/postgresql-for-wordpress.git /var/www/html/wordpress/wp-content/postgresql-for-wordpress
sudo mv /var/www/html/wordpress/wp-content/postgresql-for-wordpress/pg4wp /var/www/html/wordpress/wp-content/pg4wp
sudo rm -rf /var/www/html/wordpress/wp-content/postgresql-for-wordpress
sudo cp /var/www/html/wordpress/wp-content/pg4wp/db.php /var/www/html/wordpress/wp-content/db.php

# Установка нужных файлов
sudo rm /var/www/html/wordpress/wp-config-sample.php
sudo cp up4soft/wp-config.php /var/www/html/wordpress
sudo systemctl stop nginx && sudo rm /etc/nginx/sites-avalable/default && sudo cp up4soft/default /etc/nginx/sites-available/
sudo mv up4soft/main.html /var/www/html/ && sudo mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sudo mv up4soft/fullchain.pem /etc/letsencrypt/live/dimon-up4sost.ddns.net/ && sudo mv up4soft/privkey.pem /etc/letsencrypt/live/dimon-up4sost.ddns.net/ && sudo mv up4soft/options-ssl-nginx.conf /etc/letsencrypt/ && sudo mv up4soft/ssl-dhparams.pem /etc/letsencrypt/

# Права на файлы
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo find /var/www/html/wordpress/ -type d -exec chmod 755 {} \;
sudo find /var/www/html/wordpress/ -type f -exec chmod 644 {} \;

# Запуск
sudo systemctl start nginx
