#!/bin/sh

#include config info
source ./config.sh

cur=5
pre=$[cur-1]

#1.prepare mon_sil_sp.pho
cat ./lists/mon_sil.pho > ./lists/mon_sil_sp.pho
echo sp >> ./lists/mon_sil_sp.pho

#2.modify last hmm add sp
src=./hmms/hmm${pre}/hmmdefs
dst=./hmms/hmm${pre}/_hmmdefs
source ./add_sp2model.sh $src $dst
mv $dst $src

#3.bind sp to sil, give sil's 3th state's mean and var to sp's 2 state
hhed_once $cur sil.hed  mon_sil_sp.pho

cur=$[cur+1]
#4."hhed bind sp to sli reestimate for 2 times"
for ((i=$cur; i<$cur+2; i++));
do
{
	herest_once $i Phoneme.mlf mon_sil_sp.pho		
}
done
#now cur=8
