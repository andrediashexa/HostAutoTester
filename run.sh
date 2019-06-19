#!/bin/bash

if [ -f "/relatorio" ]
then
	rm /relatorio
fi

if [ -f "/lista" ]
then
	rm /lista
fi

echo "Coloque a seguir os IPs que deseja testar"
sleep 1s
nano /lista
echo "" >> /lista

while read lista
do
	echo $lista - $(whois $lista | grep -i NetName | awk {'print $2'})
	echo $lista >> /relatorio
	whois $lista | grep -i NetName | awk {'print $2'} >> /relatorio
	mtr -4 -r -c$1 -w -b --no-dns $lista | grep "|" >> /relatorio
	echo "" >> /relatorio

	sleep 1s
done < /lista

more /relatorio
