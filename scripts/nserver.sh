#!/bin/bash

sudo su
set -x

echo "Reading config...." >&2
source /vagrant/setup.rc

export DEBIAN_FRONTEND=noninteractive

apt-get -y update
apt-get install -y git
apt-add-repository -y ppa:ansible/ansible
apt-get install -y ansible
cd /home/vagrant
git clone http://github.com/lekdw/book-dev-env.git
chown -R vagrant:vagrant book-dev-env
cd book-dev-env/ansible
ansible-playbook -i hosts site.yml

exit 0
