#!/bin/bash

#Set the directory of report file
report=/report

if [ -f "$report" ]
then
	rm $report
	
fi

if [ -f "/tmp/lista" ]
then
	rm /tmp/lista
fi

echo "Paste every IP address that you want to test."
sleep 1s
nano /tmp/lista
echo "" >> /tmp/lista

while read lista
do
	echo $lista - $(whois $lista | grep -i NetName | awk {'print $2'})
	echo $lista >> $report
	whois $lista | grep -i NetName | awk {'print $2'} >> $report
	mtr -4 -r -c$1 -w -b --no-dns $lista | grep "|" >> $report
	echo "" >> $report

	sleep 1s
done < /tmp/lista

more $report
