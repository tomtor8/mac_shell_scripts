#!/bin/bash

# search wikipedia 

query=$1

# this code changes query iphone 6 to iphone_6, i.e. spaces are replaced by _
modifiedquery=${query//[ ]/_}

/usr/bin/open -a Safari "https://en.wikipedia.org/wiki/$modifiedquery"

