#!/bin/sh

apt-get update
apt-get install python-software-properties  -y --force-yes

add-apt-repository ppa:mapnik/boost
add-apt-repository ppa:nginx/development

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository 'deb http://ftp.utexas.edu/mariadb/repo/10.0/ubuntu trusty main'

wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
echo deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/hhvm.list

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install curl wget git nginx nodejs redis-server hhvm-nightly screen vim mariadb-server -y --force-yes

# chmod -R 777 app/storage

rm /etc/nginx/sites-enabled/default
ln -s /vagrant/conf/nginx-bgn-web /etc/nginx/sites-available/nginx-bgn-web
ln -s /etc/nginx/sites-available/nginx-bgn-web /etc/nginx/sites-enabled/nginx-bgn-web

mysql -u root < structure.sql;

service nginx reload
service hhvm restart