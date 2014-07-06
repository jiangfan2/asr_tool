#!/bin/sh

#include config info
source ./config.sh

cur=12
#1.using per make triphone bind rule
perl edfiles/maketrihed lists/mon_sil_sp.pho lists/tri.pho

#2.make triphone list and transcription
echo "make triphone list and transcription"
HLEd -n lists/tri.pho -l '*' -i labels/wintri.mlf edfiles/mktri.led labels/align.mlf

#3.copy and make triphone model
hhed_once $cur mktri.hed  mon_sil_sp.pho
cur=$[cur+1]

#4.reestimate for 2 times
for ((i=$cur; i<$cur+2; i++));
do
{
	herest_once ${i} wintri.mlf tri.pho m
}
done

#now cur=15

