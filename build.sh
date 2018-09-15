#!/bin/bash

# Assuming you already did the following to install and run this script:
#
# cd ~
# sudo yum -y install git
# git clone https://github.com/brunorijsman/reproduce-thrift-crash.git
# cd reproduce-thrift-crash.git
# ./build.sh

sudo yum -y group install 'Development Tools'

sudo yum -y install \
    ant \
    autoconf \
    automake \
    bison \
    byacc \
    flex \
    git \
    java-1.7.0-openjdk \
    libevent \
    libevent-devel \
    libtool \
    make \
    openssl-devel \
    python-devel \
    wget

cd ~
wget http://jaist.dl.sourceforge.net/project/boost/boost/1.45.0/boost_1_45_0.tar.gz
tar xzf boost_1_45_0.tar.gz
cd boost_1_45_0
./bootstrap.sh 
sudo ./bjam install

cd ~
git clone https://github.com/apache/thrift.git
cd thrift
./bootstrap.sh
./configure --with-lua=no
make
sudo make install