#!/bin/sh

#include config info
source ./config.sh

#python mkFulMonoList.py ./lists/useful_cc.dct ./lists/fulmon.pho
cur=15
#1.make full triphone list
python mkFulTriList.py ./lists/useful_cc.dct ./lists/fultri.pho

#2.prepare tree.hed
echo RO 700.0 "./stats/hmm${cur}/stats" > edfiles/tree.hed
echo TR 0 >> edfiles/tree.hed
cat edfiles/quests.hed >> edfiles/tree.hed
echo TR 2 >> edfiles/tree.hed
perl edfiles/mkclscript.prl TB 2000 lists/mon_sil.pho >> edfiles/tree.hed
echo TR 1 >> edfiles/tree.hed
echo AU "./lists/fultri.pho" >> edfiles/tree.hed
echo CO "./lists/tiedtri.pho" >> edfiles/tree.hed
echo ST "./lists/tri.tre" >> edfiles/tree.hed

#3.bind binary decision tree 
hhed_once $cur tree.hed  tri.pho
cur=$[cur+1]

#4.reestimate for 3 times
for ((i=$cur; i<$cur+3; i++));
do
{
	herest_once ${i} wintri.mlf tiedtri.pho m
}
done

#now cur=19
