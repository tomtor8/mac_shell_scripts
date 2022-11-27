#!/bin/bash

# enter path to directory
input_dir=$1
# enter extension type
input_ext=$2

for img in "$input_dir"/*."$input_ext"
do
  # use replace first match syntax $(var/from/to) 
  # replace .ext with _inverted.ext
  convert "$img" -channel RGB -negate "${img/."$input_ext"/_inverted."$input_ext"}"
done

