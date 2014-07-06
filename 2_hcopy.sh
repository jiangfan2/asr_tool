#!/bin/env bash

echo "extract feature using hcopy"
for i in ./scp/sub*;do
{
	echo "start ${i}"
	HCopy  -C configs/config_hcopy -S $i
	echo "${i} done" 
}& 
done

wait


