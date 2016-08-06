#!/bin/bash

set -o pipefail

DEPENDENCIES="git nodejs-legacy npm"
BUILD_DIR=/tmp/client

# Install build dependencies
apt-get update
apt-get install -y $DEPENDENCIES

# Get repo
git clone --depth 1 https://github.com/ushahidi/platform-client.git $BUILD_DIR

# Build
cd $BUILD_DIR
npm install -g gulp
npm install -g bower
npm install
gulp build

# Move static files to nginx root
mv $BUILD_DIR/server/www /var/

# Configure nginx
cp $BUILD_DIR/server/nginx-site.conf /etc/nginx/conf.d/default.conf
sed -i '/server_name/d' /etc/nginx/conf.d/default.conf

# cleanup
rm -rf $BUILD_DIR
apt-get purge $DEPENDENCIES -y
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
