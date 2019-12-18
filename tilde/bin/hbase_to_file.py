#!/usr/bin/python

import sys

hbaseid = sys.argv[1]
parts = hbaseid.split('_')
fileid = parts[0][::-1] + parts[1][-1]

print fileid
