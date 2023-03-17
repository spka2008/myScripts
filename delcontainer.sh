#!/bin/bash
fl="/run/media/serg/"$(ls /run/media/serg)
hd="/var/opt/cprocsp/keys/serg"
/opt/cprocsp/bin/amd64/csptest -keyset -enum -verifycontext -unique | iconv -f CP1251 -t UTF8 | awk -F '|' '{print $2}' > /tmp/delcont
declare -a mcont
i=0
for var in $(cat /tmp/delcont)
do 
    valid_date=$(/opt/cprocsp/bin/amd64/csptest -keyset -container $var -info -unique  | grep -a 'Valid' | sed 's/.\+- //; s/ [0-9][0-9]:.\+//')
    dc=$(date -d $(echo $valid_date | awk 'BEGIN{FS="."; OFS="-"} {print $3,$2,$1}') +%s) 
    dn=$(date +%s)
    if [ $dn -gt $dc ]
    then
        cont=$(echo $var| sed 's!\\!/!g ; s!//!/!')
        cont=$(echo $cont | sed "s!HDIMAGE!${hd}!; s!FLASH!${fl}!")
        cont=$(echo $cont | awk 'BEGIN{FS="/"; OFS="/"} {$NF=""; print $0}')
        mcont[i]=$cont
        #rm -r $cont
        echo "$cont истекает $valid_date"
    fi
    ((i++))
done
echo -n "Удалить контейнеры?  "
read f
f1="y"
if [ $f=$f1 ]
then
    for var in ${mcont[@]}
    do
        rm -r $var
    done
fi
unset mcont
echo -n "Очистить хранилище?  "
read f
f1="y"
if [ $f=$f1 ]
then
    /opt/cprocsp/bin/amd64/certmgr -del  -store my -all
    /opt/cprocsp/bin/amd64/csptest -absorb -cert
fi
rm /tmp/delcont
