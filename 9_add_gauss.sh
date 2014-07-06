#!/bin/sh

#include config info
source ./config.sh

cur=19

gauss=24 #final gaussions
#repeated add gauss

for ((i=2; i<=$gauss; i+=2))
do
{
	echo "start ${i} gauss"
 	
	hhed_once $cur mu${i}.hed tiedtri.pho -B
	cur=$[cur+1]
	for ((j=1; j<=4; j++))
	do	
	{
		herest_once ${cur} wintri.mlf tiedtri.pho m
		cur=$[cur+1]	
	}
	done
	
	echo "${i} gauss done!"
}
done

echo "congratulations, all down!!!!!"

