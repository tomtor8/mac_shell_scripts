# Count files in directories on PATH

- the script takes one argument `-a` that enables counting of all files including hidden files
- the script uses `sed` that substitutes colons with spaces in echo $PATH and creates a list of directories that can be iterated over in loops

# Syntax
`./counting_dir_files.sh -a` for counting all items including hidden ones
`./counting_dir_files.sh` for counting visible items

