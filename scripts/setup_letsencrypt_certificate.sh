#!/bin/bash

#Muestra todos los comandos que se van ejecutadno
set -x

# Actualizamos los repositorios
apt update

# Actualizamos los paquetes 
#apt upgrade -y

# Ponemos las variables del archivo .env
source .env