#!/bin/bash

# Переменные
DB_NAME="wordpress"
DB_USER="wpuser"
DB_PASSWORD="qwerty_123"

sudo apt update
sudo apt install -y postgresql postgresql-contrib

sudo systemctl start postgresql
sudo systemctl enable postgresql

sudo -u postgres psql <<EOF

CREATE DATABASE $DB_NAME;

CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';

GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;

ALTER USER $DB_USER WITH SUPERUSER;

EOF

echo "Установка и настройка PostgreSQL завершены."
echo "База данных: $DB_NAME"
echo "Пользователь: $DB_USER"
