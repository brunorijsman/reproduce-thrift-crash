#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/transport/TFileTransport.h>
#include <assert.h>
#include "gen-cpp/model_types.h"

using namespace apache::thrift;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;
using boost::shared_ptr;

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

void check_sample_in_terrain(Terrain& terrain, int32_t x, int32_t y, int32_t altitude)
{
    Coordinate coordinate;
    coordinate.x = x;
    coordinate.y = y;
    assert(terrain.altitude_samples[coordinate] == altitude);
}

void encode_terrain_to_file()
{
    Terrain terrain;
    add_sample_to_terrain(terrain, 10, 10, 100);
    add_sample_to_terrain(terrain, 20, 20, 200);
    add_sample_to_terrain(terrain, 30, 30, 300);

    shared_ptr<TFileTransport> transport(new TFileTransport("terrain.dat"));
    shared_ptr<TBinaryProtocol> protocol(new TBinaryProtocol(transport));
    terrain.write(protocol.get());     
}

void decode_terrain_from_file()
{
    shared_ptr<TFileTransport> transport(new TFileTransport("terrain.dat"));
    shared_ptr<TBinaryProtocol> protocol(new TBinaryProtocol(transport));

    Terrain terrain;
    terrain.read(protocol.get());

    assert(terrain.altitude_samples.size() == 3);
    check_sample_in_terrain(terrain, 10, 10, 100);
    check_sample_in_terrain(terrain, 20, 20, 200);
    check_sample_in_terrain(terrain, 30, 30, 400);
}

int main(int argc, char const *argv[])
{
    encode_terrain_to_file();
    decode_terrain_from_file();
    return 0;
}
