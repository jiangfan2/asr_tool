#!/bin/env python
#encoding:utf-8
import os
import sys
''' 
	modyfied by robin1001
	2013.12.22
'''

if __name__ == '__main__':
	if(len(sys.argv) != 3):
		print 'usage: .py in_out_file(aligne.mlf)  infile(src phoneme file)'
		sys.exit(1)		
	
	align_fid = open(sys.argv[1], 'r')
	lines = align_fid.readlines()
	aligned_labs = set([]) 
	for item in lines:
		if item.startswith("\""):
			aligned_labs.add(item[:-1])
	align_fid.close()
	#print len(aligned_labs)
	
	src_fid = open(sys.argv[2])
	src_lines = src_fid.readlines()
	align_fid = open(sys.argv[1], 'a')
	flag = False 
	count=0
	
	for item in src_lines:
		if item.startswith("\""):
			if item[:-1] not in aligned_labs:
				count+=1
				flag = True
		if flag:#lost or not
			align_fid.write(item)
			if item == ".\n":
				flag = False
	align_fid.close()
	src_fid.close()
