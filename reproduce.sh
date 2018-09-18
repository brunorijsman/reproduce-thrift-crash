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
if [ -d thrift ]; then
    cd thrift
    git pull
else
    git clone https://github.com/apache/thrift.git
    cd thrift
fi
./bootstrap.sh
./configure \
    --without-lua \
    --without-qt4 \
    --without-qt5 \
    --without-c_glib \
    --without-csharp \
    --without-java \
    --without-erlang \
    --without-nodejs \
    --without-lua \
    --without-perl \
    --without-php \
    --without-php_extension \
    --without-dart \
    --without-ruby \
    --without-haskell \
    --without-go \
    --without-rs \
    --without-cl \
    --without-haxe \
    --without-dotnetcore \
    --without-d
make
sudo make install

# Run the Thrift compiler to generate the C++ encoding and decoding functions
cd ~/reproduce-thrift-crash
thrift -gen cpp model.thrift

# Build C++ test program
g++ \
    -Wall \
    -o cpp_encode \
    cpp_encode.cpp \
    gen-cpp/model_constants.cpp \
    gen-cpp/model_types.cpp \
    -lthrift

# Run the C++ test program: serialize a Terrain object into a file, and deserialize to check
./cpp_encode

# Install virtualenv
sudo apt-get install -y virtualenv

# Create a virtual environment
virtualenv env --python=python3

# Activate the virtual environment
source env/bin/activate

# Install thrift library for Python
pip install thrift

# Run the Thrift compiler to generate the Python encoding and decoding functions
thrift -gen py model.thrift

# Run the Python test program: decode the Terrain object in the file that C++ generated
python py_decode.py
