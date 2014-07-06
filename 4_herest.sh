#!/bin/sh 

#include config info
source ./config.sh

#1.prepare mon_sil.pho

#2.flat start
#python flatstart.py ./hmms/hmm0/proto  ./lists/mon_sil.pho ./hmms/hmm0/hmmdefs 
cur=1

#current hmm 1, fist reestimate for 4 times
for ((i=$cur; i<$cur+4; i++));
do
{
	herest_once ${i} Phoneme.mlf mon_sil.pho
}
done
#now cur=5


