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

void add_sample_to_terrain(Terrain& terrain, int32_t x, int32_t y, int32_t altitude)
{
    Coordinate coordinate;
    coordinate.x = x;
    coordinate.y = y;
    std::pair<Coordinate, int32_t> sample(coordinate, altitude);
    terrain.altitude_samples.insert(sample);
}

void encode_terrain_to_file()
{
    Terrain terrain;
    add_sample_to_terrain(terrain, 10, 10, 100);
    add_sample_to_terrain(terrain, 20, 20, 200);
    add_sample_to_terrain(terrain, 30, 30, 300);
}

int main(int argc, char const *argv[])
{
    encode_terrain_to_file()
    return 0;
}
