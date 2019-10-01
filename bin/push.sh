#!/bin/bash
#i:Update remote refs along with associated objects
#u:Usage: rgit push

ROOT=$(traverse $CURRENT)
R=$?;[ $R != 0 ]&&exit $R

RSYNC=$ROOT/.rsync

REMOTE=$(cat $RSYNC/remote) || exit 1
CONFIG=$(cat $RSYNC/config) || exit 1

EXCLUDE="--exclude=.rsync"
if [ -f "$RSYNC/exclude" ];then
    while read LINE
    do
        LINE=${LINE##* }
        if [[ "$LINE" != "" && "${LINE:0:1}" != "#" ]];then
            EXCLUDE="--exclude=$LINE "$EXCLUDE
        fi
    done < $RSYNC/exclude
fi

CMD="rsync $CONFIG $EXCLUDE $ROOT/ $REMOTE/"
$CMD $@
