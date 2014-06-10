#!/bin/sh

apt-get update

add-apt-repository ppa:nginx/development

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository 'deb http://ftp.utexas.edu/mariadb/repo/10.0/ubuntu trusty main'

wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
echo deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/hhvm.list

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install git nginx hhvm mariadb-server -y --force-yes

# chmod -R 777 app/storage

rm /etc/nginx/sites-enabled/default

service nginx reload
service hhvm restart
