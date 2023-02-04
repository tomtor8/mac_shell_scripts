#!/bin/bash
# convert hex to decimal number
# see your craft documentation on binary and hexadecimal base number
validvalues=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "A" "b" "B" "c" "C" "d" "D" "e" "E" "f" "F")

while true; do
	read -r -p "Enter a hex number: " hexnum
	# get length of the number
	numlength=${#hexnum}
	# number of valid valuesi
	validvalue=0

	# check validity of the values
	for ((i = 0; i < "$numlength"; i++)); do
		numitem=${hexnum:i:1}
		for j in "${validvalues[@]}"; do
			if [[ "$numitem" == "$j" ]]; then
				((validvalue++))
				break
			fi
		done
	done

	# check if number of valid values equals that of the length of the value
	if [[ "$validvalue" -eq "$numlength" ]]; then
		echo "Valid hex number. Converting..."
		break
	else
		while true; do
			read -r -n 1 -s -p "Invalid hex number, do you wish to try again? [y/n]" answer
			echo
			case "$answer" in
			y | Y)
				# continue one loop above this while loop (the outer while loop)
				continue 2
				;;
			n | N)
				exit
				;;
			*)
				echo "Incorrect input, press Y/y or N/n."
				;;
			esac
		done
	fi
done

finalsum=0

for ((i = 0; i < "$numlength"; i++)); do
	numitem=${hexnum:i:1}
	case "$numitem" in
	f | F)
		numitem=15
		;;
	e | E)
		numitem=14
		;;
	d | D)
		numitem=13
		;;
	c | C)
		numitem=12
		;;
	b | B)
		numitem=11
		;;
	a | A)
		numitem=10
		;;
	esac
	exponent=$((numlength - (i + 1)))
	finalsum=$((finalsum + numitem * 16 ** exponent))
done

# turn the final sum into a readable format
readablesum=$(echo "$finalsum" |
	sed '{
:start
s/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/
t start
}')

echo "The converted decimal number is: $readablesum."

# -c flag to optionally copy the result to a clipboard
while getopts :c opt; do
	case "$opt" in
	c)
		echo "$finalsum" | pbcopy
		echo "-----------------------------------"
		echo "The result copied to the system clipboard."
		;;
	*)
		echo "-----------------------------------"
		echo "Unknown flag!"
		echo "List of available flags:"
		echo "-c: copy the result to the clipboard"
		;;
	esac
done
