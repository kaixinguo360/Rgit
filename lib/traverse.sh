#!/bin/bash
CURRENT=$1
while [ true ]
do
    if [ -d "$CURRENT/.rsync" ];then
        echo $CURRENT
        exit
    fi
    LAST=$CURRENT
    CURRENT=$(dirname $CURRENT)
    if [ "$CURRENT" = "$LAST" ];then
        echo "fatal: Not a rgit repository (or any of the parent directories)">&2
        exit 128
    fi
done
