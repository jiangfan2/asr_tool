#!/bin/sh

#total train list  cmd:sum=$(cat ./scp/train.scp | wc -l)
sum=115602

#process num
PN=3

#for split files in n lines
batch=$[sum/PN] 

#use one more process
#if [ $[sum%PN] -ne 0 ];
#then
#	PN=$[PN+1]
#fi



#	@param
#	$1:dest hmm dir
#	$2:label(transcription) file(phoneme.mlf or align.mlf)
#	$3:phoneme list(mon_sli.pho mon_sil_sp.pho)
#   $4:m(optional param, after align, N.mfc0-->mN.mfc0)
function herest_once()
{

    local inx=$1 #index of herest
    local pre=$[inx-1]
	local label=$2 
	local list=$3
	local i  #loop variable, avoid conflict to out 
    if [ ! -d "hmms/hmm${inx}" ]; then
        mkdir "hmms/hmm${inx}"
	fi	
    if [ ! -d "accs/hmm${inx}" ]; then
        mkdir "accs/hmm${inx}"
	fi
    if [ ! -d "stats/hmm${inx}" ]; then
        mkdir "stats/hmm${inx}"
	fi

    echo "${inx}th reestimate using herest"
    for ((i=1; i<=$PN; i++));
    do
    {
        echo "start herest process ${i}"
		if [ "$label" == "wintri.mlf" ]; then
			label_file="wintri.mlf"
		else
			label_file=${i}_${label}
		fi		
			
        HERest -p ${i} -C configs/config_lixian -I labels/${label_file} -t 250.0 150.0 1000.0 -s stats${i} -S lists/$4${i}.mfc0 -H hmms/hmm${pre}/macros -H hmms/hmm${pre}/hmmdefs -M accs/hmm${inx} lists/${list}
        echo "herest process ${i} done!"
    }&
    done
    wait

    #merge all
    echo "herest merge all"
    hres=""
    for ((i=1; i<=$PN; i++));
    do
        hres=${hres}" "accs/hmm${inx}/HER${i}.acc
    done

    HERest -T 1 -p 0 -C configs/config_lixian -t 250.0 150.0 1000.0 -s stats/hmm${inx}/stats -H hmms/hmm${pre}/macros -H hmms/hmm${pre}/hmmdefs -M hmms/hmm${inx} lists/${list} ${hres}

    echo "${inx}th reestimate done" 
}

#	@param
#	$1:dest hmm dir
#	$2:hed file(sil.hed, mktri.hed, tree.hed)
#	$3:phoneme list(mon_sil_sp.hpo, tri.pho)
#	$4:-B(binary output, optional param)
function hhed_once()
{
	local cur=$1
	local pre=$[cur-1]
	local hed=$2
	local list=$3	
	if [ ! -d "hmms/hmm${cur}" ];then
   		 mkdir "hmms/hmm${cur}"
	fi

	
	HHEd -T $4 1 -H hmms/hmm${pre}/macros -H hmms/hmm${pre}/hmmdefs -M hmms/hmm${cur} edfiles/${hed} lists/${list}

}

