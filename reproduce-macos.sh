#!/bin/bash

# Script to reproduce the following issue on macOS
# https://stackoverflow.com/questions/52377410/when-i-use-thrift-to-serialize-map-in-c-to-disk-and-then-de-serialize-it-usin
# This has been tested on macOS High Sierra 10.13.6

# I assume you already have brew installed. If not, install it as follows:
#
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# brew update

# I assume you already did the following to install and run this script:
#
# cd ~
# sudo apt-get -y install git
# git clone https://github.com/brunorijsman/reproduce-thrift-crash.git
# cd reproduce-thrift-crash
# ./reproduce-macos.sh

# Install boost
brew install boost

# Install thrift
brew install thrift

# Run the Thrift compiler to generate the C++ encoding and decoding functions
cd ~/reproduce-thrift-crash
thrift -gen cpp model.thrift

# Build C++ test program
clang++ \
    -std=c++11 \
    -stdlib=libc++ \
    -Wall \
    -o cpp_encode \
    -lthrift \
    cpp_encode.cpp \
    gen-cpp/model_types.cpp

# Run the C++ test program: serialize a Terrain object into a file, and deserialize to check
./cpp_encode

# Install virtualenv
brew install -y virtualenv

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