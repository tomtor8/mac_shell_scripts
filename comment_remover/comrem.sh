#!/bin/bash

arrayoftokens=("#" "//" "--" "@@")
tokencounter=0

while true; do
	read -r -p "Enter the filename: " filename
	if [[ ! -f "$filename" ]]; then
		echo "Enter an existing file name!"
	else
		break
	fi
done

while true; do
	read -r -p "Enter the filename of the new file: " newfile
	if [[ -z "$newfile" ]]; then
		echo "Enter a new file name!"
	elif [[ "$newfile" == "$filename" ]]; then
		echo "Choose a different name!"
	else
		break
	fi
done

while true; do
	read -r -p "Enter the comment token: " token
	if [[ -z "$token" ]]; then
		echo "Empty token, try again!"
		continue
	fi

	for i in "${arrayoftokens[@]}"; do
		if [[ "$token" == "$i" ]]; then
			echo "Token matched!"
			((tokencounter++))
		fi
	done

	if [[ "$tokencounter" -eq 0 ]]; then
		echo "Token NOT matched, try again!"
		continue
	else
		break
	fi
done

if [[ "$token" == "//" ]]; then
  token="\/\/"
fi

sed '
/'"$token"'/ {
s/'"$token"'.*//
s/[[:blank:]]*$//
/^$/ d
}
' "$filename" >"$newfile"

bat "$newfile"
