#include "gen-cpp/model_types.h"

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

    return 0;
}
