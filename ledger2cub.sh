#!/bin/bash
mkdir /tmp/mytmp
ledger accounts | awk -F ":" '/^Ass/ {print $NF }' > /tmp/mytmp/acc
sedvar='/Opening/d; /Assets:/d; s/Expenses://g; s/:/;/g' 
for var in $(cat /tmp/mytmp/acc)
do
formatledger='%(format_date(date,"%Y-%m-%d"));'$var';%(payee);;%(quantity(amount*-1));%(account)\n'
echo $formatledger 
ledger csv -r $var --format $formatledger | sed -e "${sedvar}" > /tmp/mytmp/var
awk -F ";" 'BEGIN {OFS=";"} { $4= ($5<0) ? "Расход" : "Приход"; $5=($5<0) ? $5*-1 : $5} { print $0}' /tmp/mytmp/var >> ~/ledger2Cub.csv
done
rm -r /tmp/mytmp
