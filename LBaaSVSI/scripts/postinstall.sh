#!/usr/bin/env bash 

export DEBIAN_FRONTEND=noninteractive
dpkg-reconfigure debconf -f noninteractive -p critical

hst=$(hostname -f)

sed -i "s|$hst|HOSTNAME|g" /tmp/index.html 

apt-get update -qq
apt-get upgrade -y -qq 
apt-get install apache2 -y qq

systemctl stop apache2
mv /tmp/index.html /var/www/html/index.html
systemctl start apache2
