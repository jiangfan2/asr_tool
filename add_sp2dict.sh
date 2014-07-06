#bash/bin/bash

echo -n "" > lists/useful_cc_sp.dct

while read line
do
    echo $line  >> lists/useful_cc_sp.dct
    echo -n $line  >> lists/useful_cc_sp.dct
    echo ' sp' >> lists/useful_cc_sp.dct
done < lists/useful_cc.dct

echo silence sil >> lists/useful_cc_sp.dct
echo sp sp >> lists/useful_cc_sp.dct

sed -i 's///g' lists/useful_cc_sp.dct
