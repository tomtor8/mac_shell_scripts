#!/bin/bash

# check internet connection
if wget -q --spider https://google.com; then
	if [ "$#" -eq 0 ]; then
		rclone sync gdrive:Obsidian/ $HOME/Documents/Obsidian/ -v --exclude='.obsidian/**' --exclude='.DS_Store'
		exit
	fi
	while getopts ':clw' OPTION; do
		case "$OPTION" in
		c)
			rclone sync gdrive:Obsidian/ComTech/ $HOME/Documents/Obsidian/ComTech/ -v --exclude='.obsidian/**' --exclude='.DS_Store'
			;;
		l)
			rclone sync gdrive:Obsidian/Learning/ $HOME/Documents/Obsidian/Learning/ -v --exclude='.obsidian/**' --exclude='.DS_Store'
			;;
		w)
			rclone sync gdrive:Obsidian/Work/ $HOME/Documents/Obsidian/Work/ -v --exclude='.obsidian/**' --exclude='.DS_Store'
			;;
		*)
			echo "Usage: $(basename "$0") [-c] for ComTech [-l] for Learning [-w] for Work."
			echo "The command can be used without options for syncing the whole Obsidian directory."
			;;
		esac
	done
else
	echo "Check your internet connection! Aborting sync."
	exit
fi
