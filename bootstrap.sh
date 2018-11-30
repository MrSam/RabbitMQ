#!/usr/bin/env bash

#install rabbitmq
cat >> /etc/apt/sources.list <<EOT
deb http://www.rabbitmq.com/debian/ testing main
EOT

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc

# install git
sudo apt-get -y install git

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

apt-get install -q -y screen htop vim curl wget
apt-get install -q --force-yes --reinstall -y rabbitmq-server
# RabbitMQ Plugins
service rabbitmq-server stop
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_jsonrpc
service rabbitmq-server start

rabbitmq-plugins list
rabbitmqctl add_user admin admin
rabbitmqctl set_user_tags admin administrator
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
