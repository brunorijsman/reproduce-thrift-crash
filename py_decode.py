#!/usr/bin/env python

import sys
sys.path.append('gen-py')

import thrift.protocol.TBinaryProtocol
import thrift.transport.TTransport
from model.ttypes import *

file = open("terrain.dat", "rb")
transport = thrift.transport.TTransport.TFileObjectTransport(file)
protocol = thrift.protocol.TBinaryProtocol.TBinaryProtocol(transport)
terrain = Terrain()
terrain.read(protocol)
print(terrain)
