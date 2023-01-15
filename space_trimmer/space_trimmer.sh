#!/bin/bash

read -r -p "Enter a filename to trim space: " filename

# check if file exists
if [[ ! -f "$filename" ]]; then
	echo "There is no such file, try again"
	exit 1
fi

# check double spaces in the file, if there is no
# output to STDOUT from sed, the script exits
if [[ -z $(sed -n '/  /p' "$filename") ]]; then
	echo "There are no multiple spaces in the file."
	exit
else
	echo "There are multiple spaces in the file."
	tempfile=$(mktemp tmpfile.XXXXXX)
	tempfile2=$(mktemp tmpfile2.XXXXXX)
	cp "$filename" "$tempfile"
  # while there is output to STDOUT from sed
	while [[ -n $(sed -n '/  /p; /[[:print:]][[:blank:]]\./p' "$tempfile") ]]; do
    # replace two spaces with one space globally
		sed 's/  / /g; s/[[:blank:]]\./\./g' "$tempfile" >"$tempfile2"
		cp "$tempfile2" "$tempfile"
	done
	echo "Finished trimming the file $(basename "$filename")"
	while true; do
		read -r -n 1 -s -p "Do you wish to overwrite the original file? [y/n]" answer
    echo ""
		case "$answer" in
		y | Y)
			mv "$tempfile" "$filename"
      echo "Done"
			break
			;;
		n | N)
			read -r -p "Enter a name for a new file: " newfilename
			mv "$tempfile" "$newfilename"
      echo "File $newfilename succesfully written"
			break
			;;
		*)
			echo -e "Wrong answer, y or n: "
			;;
		esac
	done
	rm -f "$tempfile2"
fi
