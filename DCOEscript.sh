#!/bin/bash

## Log file name, default 
LOGFILENAME="CyberSurfers.log"
NMAPFILENAME="CyberSurfers"
DIRECTORYNAME=$(pwd)/$NMAPFILENAME

## ID.TO-3.3 Scan active hosts with service enumeration
function ThreeThree() {
	## Start the logging for this function
	printf "[%s] Logging for ID.TO-3.3: Scanning active hosts with service enumeration\n" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME
	
	## Just getting the top 1000 (default)
	nmap $1 -sV --open | 
	while read -r line; do
		if [[ -z "$line" ]]; then
			printf "%s\n" "$line"
		else
			printf "[+] %s\n" "$line"
		fi
		printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
	done
	printf "\n"
	printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
}

## ID.TO-3.4 Create a list of active IP addresses
function ThreeFour() {
	## Start the logging for this function
	printf "[%s] Logging for ID.TO-3.4: Creating a list of active IP addresses\n" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME

	## Just getting a list of live hosts
	NmapOutput=$(nmap $1 -sP | grep report | awk '{print $5}')

	## Check if we have anything
	if [[ ! -z "$NmapOutput" ]]; then
		## Iterate through the live hosts and add them to the logfile
		for x in $NmapOutput; do
			printf "[+] %s is live!\n" "$x" 
		 	printf "[%s] %s is live!\n" "$(date +"%d%b%Y %T")" "$x" >> $DIRECTORYNAME/$LOGFILENAME
		done 
		printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
	else
		printf "[!] There are no live hosts for %s" "$1"
		printf "[%s] There are no live hosts for %s" "$(date +"%d%b%Y %T")" "$1" >> $DIRECTORYNAME/$LOGFILENAME
	fi
	printf "\n"
	printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
}

## ID.TO-3.5 Create a list of active IP addresses with key ports included
function ThreeFive() {
	## Start the logging for this function
	printf "[%s] Logging for ID.TO-3.5: Creating a list of active IP addresses with key ports included\n" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME

	## Do we have key ports we should scan?
	if [[ -z "$k" ]]; then
		printf "[!] Please supply key ports!\n"
		printf "[%s] No key ports were supplied!" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME
	else
		## Scanning with key ports
		nmap $1 -p $k --open |
		while read -r line; do
			if [[ -z "$line" ]]; then
				printf "%s\n" "$line"
			else
				printf "[+] %s\n" "$line"
			fi
			printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
		done
	fi
	printf "\n"
	printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
}

## ID.TO-3.7 Scan all ports of all hosts on given network segment
function ThreeSeven() {
	## Start the logging for this function
	printf "[%s] Logging for ID.TO-3.7: Scanning all ports of all hosts on given network segment\n" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME
	
	## Scanning all ports from 0 - 65535
	nmap $1 -p- --open | 
	while read -r line; do
		if [[ -z "$line" ]]; then
			printf "%s\n" "$line"
		else
			printf "[+] %s\n" "$line"
		fi
		printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
	done
	printf "\n"
	printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
}

if [[ $EUID -ne 0 ]]; then
	echo "[!] Please run as root!"
	exit 1
fi

if [[ $# -eq 0 ]]; then
	printf "[+] Usage: $0 -i ip/cidr -k keyports -l logfile.log\n"
	printf "Example: $0 -i 127.0.0.1 -l mylog.log\n"
	printf "Example: $0 -i 127.0.0.1/24 -k 80,443,9090\n"
	printf "Default log file is: CyberSurfers.log\n"
	exit 1
fi

while getopts ":i:k:l:" o; do
	case "${o}" in
		i ) i=${OPTARG};;
		k ) k=${OPTARG};;
		l ) l=${OPTARG};;
		* ) printf "Invalid argument!\n"; exit 1;;
	esac
done

## Was a log supplied?
if [[ ! -z "$l" ]]; then
	LOGFILENAME="$l"
fi

## Check if we have a directory to work out of
if [[ ! -d "$DIRECTORYNAME" ]]; then
	mkdir $DIRECTORYNAME
fi

until [[ "$selection" = "5" ]]; do
	printf "\n\t--==[[ DCO-E Battle Drills Script Base ]]==--\n\n"
	printf "1. Scan active hosts with service enumeration\n"
	printf "2. Create a list of active IP addresses\n"
	printf "3. Create a list of active IP address with key ports included\n"
	printf "4. Scan all ports of all hosts on given network segment\n"
	printf "5. Exit\n\n"
	printf "Selection:> "
	read selection

	case $selection in
		1 ) ThreeThree $i;;
		2 ) ThreeFour $i;;
		3 ) ThreeFive $i $k;;
		4 ) ThreeSeven $i;;
	esac
done