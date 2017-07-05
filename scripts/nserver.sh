#!/bin/bash

sudo su
set -x

echo "Reading config...." >&2
source /vagrant/setup.rc

export DEBIAN_FRONTEND=noninteractive

apt-get -y update
apt-get install -y git
apt-get install -y ansible
apt-get install sshpass -y

# change root password
echo -e "vagrant\nvagrant" | passwd root
sudo sed -i "s|PermitRootLogin prohibit-password|PermitRootLogin yes|g" /etc/ssh/sshd_config
sudo sed -i "s|#PasswordAuthentication yes|PasswordAuthentication yes|g" /etc/ssh/sshd_config
service ssh restart

cd /vagrant/etc/ansible

ansible staging -m ping -u root
ansible production -m ping -u root
ansible all -a "free -m" -u root

ansible-playbook -i hosts site.yml

exit 0

ssh-keyscan -H 192.168.82.170 >> /home/vagrant/.ssh/known_hosts
ssh-keyscan -H 192.168.82.171 >> /home/vagrant/.ssh/known_hosts
chown vagrant:vagrant /home/vagrant/.ssh/known_hosts

ssh-keyscan -H 192.168.82.170 >> /root/.ssh/known_hosts
ssh-keyscan -H 192.168.82.171 >> /root/.ssh/known_hosts
chown vagrant:vagrant /root/.ssh/known_hosts

