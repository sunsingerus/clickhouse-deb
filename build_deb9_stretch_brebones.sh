#!/bin/bash

# build ClickHouse on Debian 9 stretch

# 1
# Append in /etc/apt/sources.list entries for experimental and test packages
# Append to the end of the file:
#
# deb http://deb.debian.org/debian experimental main
# deb http://deb.debian.org/debian testing main

apt-get update
sudo apt-get -t testing install gcc-7 g++-7

sudo apt-get install llvm-5.0 llvm-5.0-dev 
sudo apt-get install clang-5.0 clang-5.0-dev 
sudo apt-get install clang++-5.0 clang++-5.0-dev 

sudo apt-get install liblld-5.0 liblld-5.0-dev

sudo apt install -y cmake libicu-dev libltdl-dev libssl-dev unixodbc-dev libreadline-dev
sudo apt install -y libc++-dev

sudo apt install -y libmariadbclient-dev

sudo apt install -y debhelper
sudo apt install -y devscripts
sudo apt install -y build-essential

# and run - specifying additonal cmake options

env CMAKE_FLAGS=" -DNO_WERROR=1" ./release



