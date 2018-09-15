#!/bin/bash

# This has been tested on Ubuntu 16.04 running in AWS

# Assuming you already did the following to install and run this script:
#
# cd ~
# sudo apt-get -y install git
# git clone https://github.com/brunorijsman/reproduce-thrift-crash.git
# cd reproduce-thrift-crash
# ./reproduce.sh

sudo apt-get -y update

# Install Thrift dependencies
sudo apt-get -y install \
    libboost-dev \
    libboost-test-dev \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-thread-dev \
    libevent-dev automake \
    libtool \
    flex \
    bison \
    pkg-config \
    g++ \
    libssl-dev

# Download, build, and install Thrift
cd ~
git clone https://github.com/apache/thrift.git
cd thrift
./bootstrap.sh
./configure --with-lua=no
make
sudo make install

# Build C++ test program
cd ~/reproduce-thrift-crash
thrift -gen cpp model.thrift
g++ -Wall -o cpp_encode cpp_encode.cpp