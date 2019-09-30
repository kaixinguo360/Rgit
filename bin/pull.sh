#!/bin/bash
#i:Fetch from and integrate with another repository or a local branch
#u:Usage: rgit pull

ROOT=$(./lib/traverse.sh $CURRENT)
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

CMD="rsync $CONFIG $EXCLUDE $REMOTE/ $ROOT/"
$CMD
