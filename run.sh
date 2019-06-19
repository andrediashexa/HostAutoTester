#!/bin/bash

if [ -f "/tmp/relatorio" ]
then
	rm /tmp/relatorio
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
	echo $lista >> /relatorio
	whois $lista | grep -i NetName | awk {'print $2'} >> /tmp/relatorio
	mtr -4 -r -c$1 -w -b --no-dns $lista | grep "|" >> /tmp/relatorio
	echo "" >> /tmp/relatorio

	sleep 1s
done < /tmp/lista

more /tmp/relatorio
