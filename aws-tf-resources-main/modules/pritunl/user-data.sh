#!/bin/bash
set -e

# Update and install dependencies
apt-get update -y
apt-get install -y gnupg curl software-properties-common wget

# Download and install libssl1.1
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb

# Add MongoDB 4.4 repository
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.4.list

# Add Pritunl repository
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
echo "deb https://repo.pritunl.com/stable/apt jammy main" > /etc/apt/sources.list.d/pritunl.list

# Update and install MongoDB and Pritunl
apt-get update -y
apt-get install -y mongodb-org pritunl

# Enable and start MongoDB and Pritunl
systemctl enable mongod pritunl
systemctl start mongod pritunl
