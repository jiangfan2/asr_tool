#!/usr/bin/env python

#author:gaigai 2013/12/3
#This program generate the modifid mfcc list by Aligned.mlf Phoneme.mlf and list.mfc0
#input:Aligned.mlf Phoneme.mlf list.mfc0
#output:mlist.mfc0

import sys

if __name__ == '__main__':
    if (len(sys.argv) != 4):
        print 'Usage: AlignedDeleteList.py infile(Aligned.mlf) infile(Phoneme.mlf) infile(list.mfc0)'
        sys.exit(1)
    inFile1 = open(sys.argv[1],'r')
    inFile2 = open(sys.argv[2],'r')
    inFile3 = open(sys.argv[3],'r')
    filename = sys.argv[3]
    # name the output file by the infile's name of list.mfc0.
    if "/" in filename:#judge the path
        filename = filename[:filename.rindex("/")+1] + "m" + filename[filename.rindex("/")+1:]
    else:
        filename = "m" + filename
    outFile = open(filename,'w')

    
    alignedContent = inFile1.readlines()
    phonemeContent = inFile2.readlines()
    mfcListContent = inFile3.readlines()

    alignedId = []
    phonemeId = []
    compareId = []

    for items in alignedContent:# get all the id in aligned file 
        if ".lab" in items:
            newitem = items[items.index("/")+1:items.rindex(".")]
            alignedId.append(newitem)

    for items in phonemeContent:# get all the id in phoneme file
        if ".lab" in items:
            newitem = items[items.index("/")+1:items.rindex(".")]
            phonemeId.append(newitem)

    alignedId.sort()
    phonemeId.sort()

    for items in phonemeId:
        if items not in alignedId:
            compareId.append(items)
    
    
    for comItem in compareId:# find the different id and delete it in the list
        for items in mfcListContent:
            if comItem in items:
                print "delete: %s" %items
                mfcListContent.remove(items)

    for items in mfcListContent:
        outFile.write(items)

    inFile1.close()
    inFile2.close()
    inFile3.close()
    outFile.close()
