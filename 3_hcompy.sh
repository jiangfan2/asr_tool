#!/bin/bash

echo "start HCompV calc golbal mean and variance"
cur=0
if [ ! -d "hmms/hmm${cur}" ];then
    mkdir "hmms/hmm${cur}"
fi
HCompV -C configs/config_lixian -f 0.01 -m -S scp/tr.scp -M hmms/hmm${cur} proto/proto

echo "hcompv done"

