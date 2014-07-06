#!/usr/bin/env python

#author:gaigai 2013/12/3
#This program generate the tri-phoneme list by full.dct
#input:full.dct
#output:fultri.pho
#Attention:this program is used to process the newdata's full.dct of training ML model.

import sys

def mktrilist(items):
    item = items.split()
    reItems = []
    for i in range(len(item)-2):
        newitem = item[i] + "-" + item[i+1] + "+" + item[i+2]
        reItems.append(newitem)
    return reItems

if __name__ == '__main__':
            
    if (len(sys.argv) != 3):
        print 'Usage: mkFulTriList_newRight.py infile(full.dct) outfile(fultri.pho)'
        sys.exit(1)
    inFile = open(sys.argv[1],'r')
    outFile = open(sys.argv[2],'w')
    content = inFile.readlines()

    fayinOne = []#mono-phoneme in this list--A
    fayinTwo = []#bi-phoneme in the list--B
    trilist = []
    templist = []
    
    for items in content:
        item = items.split()
        if len(item)==2:
            fayinOne.append(item[1])
        elif len(item) == 3:
            if item[2] != "sil":
                fayinTwo.append(item[1]+" "+item[2])
        else:
            print "The pronunciation of word '%s' more than two phoneme, please use another program to process this full.dct." % item[0]
            sys.exit(1)

    trilist.append("sp")
    trilist.append("sil")

    for itemsTwo in fayinTwo:#BB case.
        for itemsTwoCopy in fayinTwo:
            strItem = "sil" + " " + itemsTwo + " " + itemsTwoCopy  + " " +"sil"
            templist = mktrilist(strItem)
            trilist.extend(templist)
    trilist = list(set(trilist))#duplicate removal

    for itemsTwo in fayinTwo:#AB and BA case.
        for itemsOne in fayinOne:
            strItem = "sil" + " " + itemsTwo + " " + itemsOne  + " " +"sil"
            templist = mktrilist(strItem)
            trilist.extend(templist)
            strItem = "sil" + " " + itemsOne + " " + itemsTwo  + " " +"sil"
            templist = mktrilist(strItem)
            trilist.extend(templist)
    trilist = list(set(trilist))#duplicate removal

    for itemsOne in fayinOne:#AAB and BAA case.
        for itemsOneCopy in fayinOne:
            for itemsTwo in fayinTwo:
                strItem = "sil" + " " + itemsTwo + " " + itemsOne + " " + itemsOneCopy + " " +"sil"
                templist = mktrilist(strItem)
                trilist.extend(templist)
                strItem = "sil" + " " + itemsOne + " " + itemsOneCopy + " " + itemsTwo + " " +"sil"
                templist = mktrilist(strItem)
                trilist.extend(templist)
        trilist = list(set(trilist))#duplicate removal

    for itemsOne in fayinOne:#BAB case.
        for itemsTwo in fayinTwo:
            for itemsTwoCopy in fayinTwo:
                strItem = "sil" + " " + itemsTwo + " " +  itemsOne + " " + itemsTwoCopy + " " +"sil"
                templist = mktrilist(strItem)
                trilist.extend(templist)
        trilist = list(set(trilist))#duplicate removal

    for itemsOne in fayinOne:#AAA case
        for itemsOneCopy1 in fayinOne:
            for itemsOneCopy2 in fayinOne:
                strItem = "sil" + " " + itemsOne + " " + itemsOneCopy1 + " " + itemsOneCopy2 + " " +"sil"
                templist = mktrilist(strItem)
                trilist.extend(templist)
        trilist = list(set(trilist))#duplicate removal
    
    for itemsOne in fayinOne:#A case
        strItem = "sil" + " " + itemsOne + " " + "sil"
        templist = mktrilist(strItem)
        trilist.extend(templist)

    trilist = list(set(trilist))#duplicate removal
    trilist.sort()#sort the trilist
    
    for items in trilist:
        outFile.write(items)
        outFile.write("\n")

    inFile.close()
    outFile.close()
    
