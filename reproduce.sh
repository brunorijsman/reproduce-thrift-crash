#!/bin/bash

sudo yum -y group install 'Development Tools'

sudo yum -y install \
    ant \
    autoconf \
    automake \
    bison \
    byacc \
    boost \
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

git clone https://github.com/apache/thrift.git
cd thrift
./bootstrap.sh
./configure --with-lua=no
make
sudo make install