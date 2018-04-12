#!/bin/bash

sudo apt install -y debhelper
sudo apt install -y pbuilder
sudo apt install -y debootstrap


ln -s gutsy /usr/share/debootstrap/scripts/artful

echo "3.0 (native)" > debian/source/format

#$DIST

#ARCH=i386
#ARCH=amd64

# 16.04
sudo DIST=xenial pbuilder create --configfile debian/.pbuilderrc && DIST=xenial pdebuild --configfile debian/.pbuilderrc
ls -lh /var/cache/pbuilder/xenial-amd64/result/*.deb

# 14.04
sudo DIST=trusty pbuilder create --configfile debian/.pbuilderrc && DIST=trusty pdebuild --configfile debian/.pbuilderrc
ls -lh /var/cache/pbuilder/trusty-amd64/result/*.deb

# deb 9 - stretch
sudo DIST=stretch pbuilder create --configfile debian/.pbuilderrc && DIST=stretch pdebuild --configfile debian/.pbuilderrc
ls -lh /var/cache/pbuilder/stable-amd64/result/*.deb
