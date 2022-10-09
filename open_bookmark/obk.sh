#!/bin/bash

echo "Which browser would you like to use? Safari (default) or Chrome (c)?"
read -r answer

if [ "$answer" == "c" ]
then
	browser="Google Chrome"
else
	browser="Safari"
fi

page=$(buku -p -f 40 | fzf | cut -f1)
# prevent opening empty value in safari if esc key pressed
if [ "$page" != "" ]
then
	open -a "$browser" "$page"
else
	echo "Search aborted!"
fi
