#!/bin/bash

if [[ $# != 2 ]]; then
    echo 'Usage: add_sp.sh modelfile add_sp_model_file'
    exit 1
fi

modelfile=$1
sp_modelfile=$2

trans_prob=$(grep -A 27 '~h "sil"' $modelfile | grep -A 3 '<TRANSP> 5' | tail -n1 | awk '{print $3}')
rest_prob=$(echo $trans_prob | awk '{printf("%e", 1.0 - $1);}')

#output
cp $modelfile $sp_modelfile
echo -e '~h "sp"\n<BEGINHMM>\n<NUMSTATES> 3' >> $sp_modelfile
grep -A 27 '~h "sil"' $modelfile | grep -A 5 '<STATE> 3' | sed 's:<STATE> 3:<STATE> 2:' >> $sp_modelfile
echo -e "<TRANSP> 3\n 0.000000e+00 1.000000e+00 0.000000e+00\n 0.000000e+00 $trans_prob ${rest_prob}\n 0.000000e+00 0.000000e+00 0.000000e+00\n<ENDHMM>" >> $sp_modelfile
