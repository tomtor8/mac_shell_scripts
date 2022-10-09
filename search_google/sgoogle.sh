#!/bin/bash

# search google

query=$1

# this code changes query iphone 8 to iphone+8, i.e. spaces are replaced by +
modifiedquery=${query//[ ]/+}

/usr/bin/open -a Safari "https://www.google.com/search?q=$modifiedquery"
