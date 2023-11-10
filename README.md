# Practica-01-05
La practica número 5 del modulo de IAW
Nos registraremos en la pagina: https://www.noip.com/es-MX para hacer un dominio con nuestra IP de la instancia creada de AWS. Mi dominio es: practica01-06gsm.hopto.org
Crearemos una carpeta llamada "scripts" con 3 archivos: "*setup_letsencrypt_certificate.sh*", "*install_lamp.sh*" y "*.env*"
Y otra carpeta llamada "conf" con 1 archivo: "*000-default.conf*"
A continuación los contenidos de cada archivo y lo que hace cada cosa:

### install_lamp.sh

    #!/bin/bash

Muestra todos los comandos que se van ejecutando

    set  -ex

Actualizamos los repositorios

    apt  update 

Actualizamos los paquetes

    apt upgrade -y

Instalamos el servidor web **Apache**

    apt  install  apache2  -y

  
  Instalar el sistema gestor de datos **MySQL**

    apt  install  mysql-server  -y

Configuramos las variables para entrar a **MySQL**

    DB_USER=usuario
    DB_PASSWD=contraseña

  Entrar a **MySQL**

    mysql -u $DB_USER -p$DB_PASSWD < ../sql/database.sql

Instalamos **PHPMyAdmin**

    sudo  apt  install  php  libapache2-mod-php  php-mysql  -y

Reiniciamos **Apache**

    systemctl  restart  apache2

Modificamos el propietario de la carpeta */var/www/html*

    chown  -R  www-data:www-data  /var/www/html

### setup_letsencrypt_certificate.sh

    #!/bin/bash

Muestra todos los comandos que se van ejecutando

    set  -x

Actualizamos los repositorios

    apt  update

Actualizamos los paquetes

    apt upgrade -y

  

Ponemos las variables del archivo *.env*

    source  .env

  Instalamos y actualizamos **Snap**

    snap  install  core
    snap  refresh  core

  

Eliminamos cualquier instalación previa de **Certbot** con *apt*

    apt  remove  certbot

Instalamos la aplicación **Certbot**

    snap  install  --classic  certbot

  Creamos una alias para el comando **Certbot**.

    ln  -fs  /snap/bin/certbot  /usr/bin/certbot

  

Obtenemos el certificado y configuramos el servidor web **Apache**

Ejecutamos el comando **Certbot**

    certbot  --apache  -m  $CERTIFICATE_EMAIL  --agree-tos  --no-eff-email  -d  $CERTIFICATE_DOMAIN  --non-interactive


### .env

    CERTIFICATE_EMAIL=guilleemail@demo.es
    CERTIFICATE_DOMAIN=practicagsmhttps.hopto.org


### 000-default.conf
Modificamos el archivo de configuración 
   

     <VirtualHost *:80>
            # ServerName practica-https.local
            DocumentRoot /var/www/html
        
            # Redirige al puerto 443 (HTTPS)
            RewriteEngine On
            RewriteCond %{HTTPS} off
            RewriteRule ^ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
        </VirtualHost>
