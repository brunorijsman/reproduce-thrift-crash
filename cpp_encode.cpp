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
    Coordinate coordinate;
    Terrain terrain;

    coordinate.x = 10
    coordinate.y 

    return 0;
}
