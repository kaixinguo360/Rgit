#!/bin/bash
#i:Update remote refs along with associated objects
#u:Usage: rgit push

ROOT=$(./lib/traverse.sh $CURRENT)
R=$?;[ $R != 0 ]&&exit $R

echo $PWD
