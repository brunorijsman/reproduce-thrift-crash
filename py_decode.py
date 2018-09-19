#!/usr/bin/env python

import sys
sys.path.append('gen-py')

import thrift.protocol.TBinaryProtocol
import thrift.transport.TTransport
import model.ttypes

def decode_terrain_from_file():
    file = open("terrain.dat", "rb")
    transport = thrift.transport.TTransport.TFileObjectTransport(file)
    protocol = thrift.protocol.TBinaryProtocol.TBinaryProtocol(transport)
    terrain = model.ttypes.Terrain()
    terrain.read(protocol)
    print(terrain)

if __name__ == "__main__":
    decode_terrain_from_file()
    