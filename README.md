If needed, install HomeBrew:

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update

If needed, install boost:

    brew install boost

If needed, install thrift:

    brew install thrift

Clone the github repository:

    git clone https://github.com/brunorijsman/reproduce-thrift-crash.git

Create and activate a Python virtual environment:

    cd reproduce-thrift-crash
    virtualenv env --python=python3
    source env/bin/activate

Run the Thrift compiler to generate the Python encoding and decoding functions:

    thrift -gen py model.thrift

Run the Thrift compiler to generate the C++ encoding and decoding functions:

    thrift -gen cpp model.thrift
