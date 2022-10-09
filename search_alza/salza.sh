#!/bin/bash

# search alza.sk

query=$1

# this code changes query iphone 6 to iphone%206, i.e. spaces are replaced by %20
modifiedquery=${query//[ ]/%20}

/usr/bin/open -a Safari "https://www.alza.sk/search.htm?exps=$modifiedquery"

