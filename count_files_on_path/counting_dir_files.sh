#!/bin/bash

listoption=""
texthidden=" (without hidden items)"

# script accepts only one parameter -a that
# stands for all files including hidden ones
while getopts :a opt; do
	case "$opt" in
	a)
		listoption="-a"
		texthidden=" (including hidden items)"
		;;
	*)
		echo "Invalid option. Try -a as an option"
		exit
		;;
	esac
done

# sed substitutes : with space and thus create a list of dirs
listofdirsinpath=$(echo "$PATH" | sed 's/:/ /g')
countofdirs=0
totalcountoffiles=0

for diritem in $listofdirsinpath; do
	countofdirs=$((countofdirs + 1))
	echo "$countofdirs: $diritem"
	case "$listoption" in
	-a)
		listoffiles=$(ls -a "$diritem")
		;;
	*)
		listoffiles=$(ls "$diritem")
		;;
	esac
	countoffiles=0
	for fileitem in $listoffiles; do
		countoffiles=$((countoffiles + 1))
	done
	echo "Number of items is $countoffiles."
	totalcountoffiles=$((totalcountoffiles + countoffiles))
done
echo ""
echo "The total number of items on your PATH is $totalcountoffiles$texthidden."
