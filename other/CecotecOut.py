#!/usr/bin/env python3
import os.path as path
from distutils.util import strtobool
import sys
import os
import time
import binascii

class Module:
    def __init__(self, incoming=False, verbose=False, options=None):
        # extract the file name from __file__. __file__ is proxymodules/name.py
        self.name = path.splitext(path.basename(__file__))[0]
        self.description = 'Cecotec protocol out module'
        self.verbose = verbose
        self.source = None
        self.destination = None
        self.incoming = incoming
        if options is not None:
            if 'verbose' in options.keys():
                self.verbose = bool(strtobool(options['verbose']))

    def execute(self, data):

        size = len(data)
        msg = "Received %d bytes" % size
        ts = time.time()
        sc=';'
        nl = '\n'

        if self.verbose:
            msg += " from %s:%d" % self.source
            msg += " for %s:%d" % self.destination

        #print(data)

        my_data = []
        my_data.append('out') # DIRECTION
        my_data.append(str(ts)) # DIRECTION
        my_data.append(str(int.from_bytes(data[0:4],byteorder=sys.byteorder))) # SIZE
        my_data.append(str(int.from_bytes(data[4:5],byteorder=sys.byteorder))) # CTYPE
        my_data.append(str(int.from_bytes(data[5:6],byteorder=sys.byteorder))) # FLOW
        my_data.append(str(int.from_bytes(data[6:9],byteorder=sys.byteorder))) # CID
        my_data.append(str(int.from_bytes(data[10:14],byteorder=sys.byteorder))) # DID
        my_data.append(hex(int.from_bytes(data[14:22],byteorder='little'))) # SEQ
        strcommand=str(int.from_bytes(data[22:24],byteorder='little'))
        #command1="grep '\s"+strcommand+"\s' robotfunctions.txt  | awk '{print $NF}' | xargs"
        #stdoutcommand=os.popen(command1 ).read().strip()
        #my_data.append(stdoutcommand) # NAME
        my_data.append(strcommand) # COMMAND

        print(f"{sc.join(my_data)}")

        if len(data)>24:
            #print(protobuf " + str(data[24:]))
            protobuf_data = str(data[24:].hex())
            binary_data = binascii.unhexlify(protobuf_data)
            with open("blob-file-out", "wb") as f: f.write(binary_data)
            stdout=os.popen('../protobuf-inspector/main.py < blob-file-out').read()
            print(stdout)

        return data

    def help(self):
        h = '\tverbose: override the global verbosity setting'
        return h


if __name__ == '__main__':
    print('This module is not supposed to be executed alone!')
