#!/bin/bash
i=$(< config.ini)
url="pda.pogoda.by";
ping -q -c1 $url | grep recieved | awk '{print $1}'
if  [ $? -eq 0 ]
then
	echo "ok"

    		wget -q -O- $url | iconv -f cp1251 -t utf8>tmp.txt>> tmp.txt
	#awk '/Температура/ {print}' tmp.txt 
	echo `cat ./tmp.txt | grep -A 1 "погода фактическая"| sed 's/<br>/\n/g'|sed 's/<[^>]*>/ /g'`
    	sleep $i
	rm tmp.txt
else
	echo "no connection"
fi


