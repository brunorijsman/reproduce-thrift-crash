#!/usr/bin/env python

import sys
sys.path.append('gen-py')

import thrift.protocol.TBinaryProtocol
import thrift.transport.TTransport
import model.ttypes

model.ttypes.Coordinate.__hash__ = lambda self: hash((self.x, self.y))

model.ttypes.Coordinate.__eq__ = lambda self, other: hash((self.x, self.y) == (other.x, other.y))

def encode_terrain_to_file():
    amplitude_samples = {
        model.ttypes.Coordinate(x=10, y=10): 100,
        model.ttypes.Coordinate(x=20, y=20): 200,
        model.ttypes.Coordinate(x=30, y=30): 300,
    }
    terrain = model.ttypes.Terrain(amplitude_samples)
    print(terrain)
    file = open("terrain.dat", "wb")
    transport = thrift.transport.TTransport.TFileObjectTransport(file)
    protocol = thrift.protocol.TBinaryProtocol.TBinaryProtocol(transport)
    terrain.write(protocol)

if __name__ == "__main__":
    encode_terrain_to_file()
    