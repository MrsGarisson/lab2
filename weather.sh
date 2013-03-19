#!/bin/bash
i=$(< config.ini)
url="pda.pogoda.by";
ping -q -c1 $url | grep recieved | awk '{print $1}'
if  [ $? -eq 0 ]
then
    	wget -q -O- $url | iconv -f cp1251 -t utf8>tmp.txt>> tmp.txt
	weather=`cat ./tmp.txt | grep -A 1 "погода фактическая"| sed 's/<br>/\n/g'|sed 's/<[^>]*>/ /g'`
	echo -e "$weather"
	echo
	echo
    	sleep $i
	rm tmp.txt
else
	echo "no connection"
fi


