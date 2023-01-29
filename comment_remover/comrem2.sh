#!/bin/bash

function matched() {
	echo "Token matched!"
}

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

	case "$token" in
	"#")
		matched
		break
		;;
	"//")
		token="\/\/"
		matched
		break
		;;
	"--")
		matched
		break
		;;
	*)
		echo "Incorrect token, try again!"
		continue
		;;
	esac
done
# the following command work only on lines that contain a token
sed '
/'"$token"'/ {
s/'"$token"'.*//
s/[[:blank:]]*$//
/^$/ d
}
' "$filename" >"$newfile"

bat "$newfile"
