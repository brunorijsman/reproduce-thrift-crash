#!/usr/bin/env python

import sys
sys.path.append('gen-py')

import thrift.protocol.TBinaryProtocol
import thrift.transport.TTransport
from model.ttypes import *

transport = thrift.transport.TTransport.TFileObjectTransport("terrain.dat")
protocol = thrift.protocol.TBinaryProtocol.TBinaryProtocol(transport)
terrain = Terrain()
terrain.read(protocol)
print(terrain)

