#!/bin/bash

# Muestra todos los comandos que se van ejecutadno
set -ex

# Actualizamos los repositorios
apt update

# Actualizamos los paquetes 
#apt upgrade -y

# Instalamos el servidor web Apache
apt install apache2 -y


# Instalar  el sistema gestor de datos MySQL
apt install mysql-server -y

#DB_USER=usuario
#DB_PASSWD=contraseña

#mysql -u $DB_USER -p$DB_PASSWD < ../sql/database.sql

# Instalamos php
sudo apt install php libapache2-mod-php php-mysql -y

# Reiniciamos servicio
systemctl restart apache2

# Modificamos el propietario
chown -R www-data:www-data /var/www/html