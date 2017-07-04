#!/bin/bash

sudo su
set -x

echo "Reading config...." >&2
source /vagrant/setup.rc

export DEBIAN_FRONTEND=noninteractive

apt-get -y update
apt-get install wget unzip build-essential libgd2-xpm-dev apache2-utils -y

exit 0
