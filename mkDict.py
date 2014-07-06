#!/usr/bin/env python

#author:gaigai 2013/12/2
#This program generate the useful.dct by syl.mlf and full.dct
#input:syl.mlf full.dct
#output:useful.dct

import sys

if __name__ == '__main__':
    if (len(sys.argv) != 4):
        print 'Usage: mkDict.py infile(syl.mlf) infile(full.dct) outfile(useful.dct)'
        sys.exit(1)
    inFile1 = open(sys.argv[1], 'r')
    inFile2 = open(sys.argv[2], 'r')
    outFile = open(sys.argv[3], 'w')
    content = inFile1.readlines()
    newitem = []
    for items in content:#this loop extracts the words in syl.mlf
        if ".lab" not in items:
            if "#" not in items:
                if "." not in items:
                    items = items[:len(items)-1] #delete the "\n" in the end
                    newitem.append(items)
    orderitem = list(set(newitem))
    orderitem.sort()

    phoneSet = inFile2.readlines()

    for items in phoneSet:
        item =items.split()
        if item[0] in orderitem: #if in the set then output it
            outFile.write(items)

    inFile1.close()
    inFile2.close()
    outFile.close()
            
