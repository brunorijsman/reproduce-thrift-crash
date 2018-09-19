// This is the a trivial program which does not actually do anything, it just includes the 
// header file that Thrift generated. This is to see if the code which Thrift generates compiles
// and links. 
//
// See: https://stackoverflow.com/questions/52340266/code-generated-by-thrift-gen-cpp-does-not-compile-on-macos-boost-tr1-functi

#include "gen-cpp/model_types.h"

// Thrift generates the declaration but not the implementation of operator< because it has no way
// of knowning what the criteria for the comparison are. So, provide the implementation here.
bool Coordinate::operator<(const Coordinate& other) const
{
    if (x < other.x) {
        return true;
    } else if (x > other.x) {
        return false;
    } else if (y < other.y) {
        return true;
    } else {
        return false;
    }
}

int main(int argc, char const *argv[])
{
    return 0;
}