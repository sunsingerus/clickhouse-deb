#!/bin/bash

# Git version of ClickHouse
CH_VERSION="${CH_VERSION:-1.1.54385}"

# Git tag marker (stable/testing)
CH_TAG="${CH_TAG:-stable}"
#CH_TAG="${CH_TAG:-testing}"

#
# Prepare sources
#

echo "Clone ClickHouse repo"
git clone "https://github.com/yandex/ClickHouse" "ClickHouse-${CH_VERSION}-${CH_TAG}"

cd "ClickHouse-${CH_VERSION}-${CH_TAG}"

echo "Checkout specific tag v${CH_VERSION}-${CH_TAG}"
git checkout "v${CH_VERSION}-${CH_TAG}"

echo "Update submodules"
git submodule update --init --recursive

#
# Install build dependencies
#

sudo apt install -y debhelper
sudo apt install -y pbuilder
sudo apt install -y debootstrap

#
# Polish sources
#

ln -s gutsy /usr/share/debootstrap/scripts/artful

echo "3.0 (native)" > debian/source/format

#
# Build for 16.04
#

sudo DIST=xenial pbuilder create --configfile debian/.pbuilderrc && DIST=xenial pdebuild --configfile debian/.pbuilderrc

#
# List results
#

ls -lh /var/cache/pbuilder/xenial-amd64/result/*.deb

