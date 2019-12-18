#!/usr/bin/python

import sys

fileid = sys.argv[1]
filetype = sys.argv[2] if len(sys.argv) > 2 else "file"
hbaseid = fileid[::-1][1:] + "_" + filetype + fileid[-1]

print hbaseid
print "get 'document', \"{}\"".format(hbaseid)
