#!/bin/bash

# enter path to directory
input_dir=$1
# enter extension type
input_ext=$2

# check if argument is empty string
# if so throw an error
if [[ -z "$input_dir" ]]
then
  echo "Specify an input directory!"
  exit 1
fi

if [[ -z "$input_ext" ]]
then
  echo "Specify a picture extension!"
  exit 1
fi

# iterate through files in the input directory
# with the specified extension
for img in "$input_dir"/*."$input_ext"
do
  # use replace first match syntax $(var/from/to)
  # replace .ext with _inverted.ext
  convert "$img" -channel RGB -negate "${img/.$input_ext/_inverted.$input_ext}"
done

