#!/usr/bin/env python

#author:gaigai 2013/12/3
#This program generate the hmmdefs by proto and mon_sil.pho
#input:proto mon_sil.pho
#output:hmmdefs

import sys

if __name__ == '__main__':
    if (len(sys.argv) != 4):
        print 'Usage: flatstart.py infile(proto) infile(mon_sil.pho) outfile(hmmdefs)'
        sys.exit(1)
    inFile1 = open(sys.argv[1],'r')
    inFile2 = open(sys.argv[2],'r')
    outFile = open(sys.argv[3],'w')
    content = inFile1.readlines()
    head = content[3] #get the head containing "~h"
    body = content[4:] #get the hmm body
    phoneSet = inFile2.readlines()

    for items in phoneSet:
        items = items[:len(items)-1]
        items = "\"" + items + "\"\n"
        item = head.split()
        newitem = item[0] + " " +items
        outFile.write(newitem)
        for bodyitem in body:
            outFile.write(bodyitem)

    inFile1.close()
    inFile2.close()
    outFile.close()
    
        
        
        
        

        
