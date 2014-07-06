#!/bin/sh

#include config info
source ./config.sh

#data prepare
#1.train.scp(train mfc list) train_map.scp(train map wav->mfc) tr.scp(for hcompv init mean and variance)
#2.full dict, useful_dict, pinyin.mlf, phoneme.mlf
#3.monophone list(mon.pho mon_sil.pho mon_sil_sp.pho)
#4.config(config_hcopy config_lixian)
#5.proto
#6.edfiles(all)


#echo "split scp and phoneme files"
##split train_scp
#split -l $batch -d ./scp/train_map.scp  ./scp/map
##split mfc list, train.scp
#split -l $batch -d ./scp/train.scp ./scp/scp
#i=1
#for file in ./scp/scp*;
#do
#{
#	mv $file $i.scp
#	i=$[i+1]
#}
#done
#
##split label and phoneme files

#make syl.mlf
echo -n "" > ./labels/syl.mlf
for ((i=1; i<= $PN; i++));
do
{
	cat ./labels/${i}_Pinyin.mlf >> ./labels/syl.mlf
}
done

#make useful_cc.dct
python mkDict.py ./labels/syl.mlf ./lists/full.dct ./lists/useful_cc.dct

#make monophone list
python mkMonoList.py ./lists/useful_cc.dct ./lists/mon.pho

#add sil 
cat ./lists/mon.pho > ./lists/mon_sil.pho
echo sil >> ./lists/mon_sil.pho

