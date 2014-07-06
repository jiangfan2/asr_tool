#!/usr/bin/env python

#author:gaigai 2013/12/2
#This program generate the fulmonolist by full.dct
#input:full.dct
#output:fulmonolist

import sys

if __name__ == '__main__':
    if (len(sys.argv) != 3):
        print 'Usage: mkFulMonoList.py infile(full.dct) outfile(fulmonolist)'
        sys.exit(1)
    inFile = open(sys.argv[1], 'r')
    outFile = open(sys.argv[2], 'w')
    content = inFile.readlines()
    newitem = []
    for items in content:
        items.strip() #delete the \n in the end of every row.
        item = items.split() 
        item = item[1:]
        newitem.extend(item)
    orderitem = list(set(newitem))
    orderitem.sort()

    for items in orderitem:
        if items != "[]": #do not output [] for it is not the phoneme.
            outFile.write(items)
            outFile.write("\n")

    inFile.close()
    outFile.close()
    
    
