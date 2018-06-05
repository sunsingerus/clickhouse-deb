#!/bin/bash

# build ClickHouse on Debian 9 stretch

# 1
# Append in /etc/apt/sources.list entries for experimental and test packages
# Append to the end of the file:
#
# deb http://deb.debian.org/debian experimental main
# deb http://deb.debian.org/debian testing main
sudo bash -c 'echo "deb http://deb.debian.org/debian testing main" >> /etc/apt/sources.list'

sudo apt-get update
sudo apt-get install -y gcc-7 g++-7

sudo apt-get install -y llvm-5.0 llvm-5.0-dev 
sudo apt-get install -y clang-5.0 clang-5.0-dev 
sudo apt-get install -y clang++-5.0 clang++-5.0-dev 

sudo apt-get install -y liblld-5.0 liblld-5.0-dev

sudo apt install -y cmake libicu-dev libltdl-dev libssl-dev unixodbc-dev libreadline-dev
sudo apt install -y libc++-dev
sudo apt install -y ninja-build

sudo apt install -y libmariadbclient-dev

sudo apt install -y debhelper
sudo apt install -y devscripts
sudo apt install -y build-essential

# and run - specifying additonal cmake options

env CMAKE_FLAGS=" -DNO_WERROR=1" ./release


# and look for .deb files one level up

ls -l ../*.deb
