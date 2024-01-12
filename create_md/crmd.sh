#!/usr/bin/env bash

# A script to create a new md file with supplied name as positional parameter

file_name="$1"

# must be one positional parameter if not exit
if [[ "$#" -ne 1 ]]; then
  echo "Number of positional parameters must be 1 (filename without extension)."
  exit 1
fi

# parameter must not be empty if so exit
if [[ -z "$file_name" ]]; then
  echo "Empty parameter. No filename provided."
  exit 1
fi

# create a file
file_path="$HOME/Documents/$file_name.md"

# if the filename is already taken, exit
if [[ -f "$file_path" ]]; then
  echo "The filename already exists, choose another one."
  exit 1
else
  touch "$file_path"
fi

# check if the file exists
# if so open it with Typora
if [[ -f "$file_path" ]]; then
  open -a Typora "$file_path"
else
  echo "Error: The file does not exist!"
  exit 1
fi
