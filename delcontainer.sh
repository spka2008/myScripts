#!/bin/bash
if [ -n "$1" ] 
then
    /opt/cprocsp/bin/amd64/csptest -keyset -enum -verifycontext -unique | iconv -f CP1251 -t UTF8| grep  'FLASH' | sed  's/.\+FLASH/FLASH/' > /tmp/delcont
    for var in $(cat delcont)
    do 
        var1=$(/opt/cprocsp/bin/amd64/csptest -keyset -container $var -info | grep -a 'Valid' | sed 's/.\+- //; s/ [0-9][0-9]:.\+//')
        dc=$(date -d $(echo $var1 | awk 'BEGIN{FS="."; OFS="-"} {print $3,$2,$1}') +%s) 
        dn=$(date +%s)
        if [ $dn -gt $dc ]
        then
            var=$1$(echo $var | sed 's!FLASH!! ; s!\\!/!g ; s!//!/!')
            var=$(echo $var | awk 'BEGIN{FS="/"; OFS="/"} {$NF=""; print $0}')
            rm -r $var
            echo "$var истек $var1"
        fi
    done
else echo "Адрес флешки?"
fi
rm /tmp/delcont
