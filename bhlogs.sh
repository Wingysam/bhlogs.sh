#!/bin/bash

logfile=$1
command=$2
ign=$(echo $3 | tr '[:lower:]' '[:upper:]')

if [ $command == chat ]
then
	if [ -z $ign ]
	then
		cat $logfile | sed 's/^.*] //g' | grep "^.*: " | grep -v ^.*:\ / | sed 's/^.*: //g'
	else
		cat $logfile | sed 's/^.*] //g' | grep "^$ign: " | grep -v ^.*:\ / | sed 's/^.*: //g'
	fi
fi

if [ $command == players ]
then
	cat $logfile | grep 'Player Disconnected' | sed 's/^.* - Player Disconnected //g' | sort -u
fi

if [ $command == commands ]
then
	if [ -z $ign ]
	then
		cat $logfile | sed 's/^.*] //g' | grep ^.*: | grep '^.*: /'
	else
		cat $logfile | sed 's/^.*] //g' | grep ^$ign: | sed "s/^$ign: //g" | grep ^/
	fi
fi

if [ $command == servernames ]
then
	cat $logfile | head -1 | sed 's/^.*\] Creating new world named "//g' | sed 's/"$//g'
	cat $logfile | grep '] Renamed ".*" to ".*"$' | sed 's/"$//g' | sed 's/^.*"//g'
fi

if [ $command == chatcommands ]
then
	if [ -z $ign ]
	then
		cat $logfile | sed 's/^.*] //g' | grep '^.*: ' | sed "s/^$ign: //g"
	else
		cat $logfile | sed 's/^.*] //g' | grep "^$ign: " | sed 's/^.*: //g'
	fi
fi
