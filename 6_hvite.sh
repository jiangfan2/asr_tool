#!/bin/sh

source ./config.sh
cur=8
pre=$[cur-1]
#1.add sp 2 dict
source ./add_sp2dict.sh

#2 do align
for ((i=1; i<=$PN; i++));
do
{
	HVite -y lab -T 8 -l '*' -o SWT -b silence -C configs/config_lixian -a -H hmms/hmm${pre}/macros -H hmms/hmm${pre}/hmmdefs -i labels/${i}_align.mlf -m -t 250.0 -I labels/${i}_Pinyin.mlf -S lists/${i}.mfc0 lists/useful_cc_sp.dct lists/mon_sil_sp.pho
}
done

#3.fixed lost 
for ((i=1; i<=$PN; i++));
do 
{
	python AlignedDeleteList.py ./labels/${i}_align.mlf labels/${i}_Phoneme.mlf ./lists/${i}.mfc0
}
done

#4.merge all
echo -n ""  > labels/align.mlf
for ((i=1; i<=$PN; i++));
do
{
	cat labels/${i}_align.mlf >> labels/align.mlf
}
done	

#5.reestimate for 4 times
for ((i=$cur; i<$cur+4; i++));
do
{
	herest_once ${i} align.mlf mon_sil_sp.pho m
}
done
#now cur=12

