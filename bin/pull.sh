#!/bin/bash
#i:Fetch from and integrate with another repository or a local branch
#u:Usage: rgit pull

PWD=$(./lib/traverse.sh $CURRENT)
R=$?;[ $R != 0 ]&&exit $R

echo $PWD
