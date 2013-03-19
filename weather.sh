#!/bin/bash
i=$(< config.ini)
url="pda.pogoda.by";
if [[ $1 == "--help" || $1 == "-h" ]];
then
echo I print weather every $i seconds.
exit 0
fi
ping -q -c1 $url | grep recieved | awk '{print $1}'
if  [ $? -eq 0 ]
then
	while true  
	do  	
		wget -q -O- $url | iconv -f cp1251 -t utf8>tmp.txt>> tmp.txt
		weather=`cat ./tmp.txt | grep -A 1 "погода фактическая"| sed 's/<br>/\n/g'|sed 's/<[^>]*>/ /g'`
		echo -e "$weather"
		echo
		echo
    		sleep $i
		rm tmp.txt
	done
else
	echo "no connection"
fi


