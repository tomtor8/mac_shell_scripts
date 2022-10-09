#!/bin/bash

# search youtube

query=$1

# this code changes query iphone 6 to iphone+6, i.e. spaces are replaced by +
modifiedquery=${query//[ ]/+}

/usr/bin/open -a Safari "https://www.youtube.com/results?search_query=$modifiedquery"

