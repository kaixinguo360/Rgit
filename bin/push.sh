#!/bin/bash
#i:Update remote refs along with associated objects
#u:Usage: rgit push

ROOT=$(traverse $CURRENT) || exit
RSYNC=$ROOT/.rsync

REMOTE=$(cat $RSYNC/remote) || exit
CONFIG=$(cat $RSYNC/config) || exit

EXCLUDE="--exclude=.rsync"
if [ -f "$RSYNC/exclude" ];then
    EXCLUDE="--exclude-from=$RSYNC/exclude "$EXCLUDE
fi

BACKUP_PATH=.rsync/backup/$(date '+%Y/%m/%d/%H%M%S')
BACKUP="-b --backup-dir $BACKUP_PATH"

CMD="rsync $@ $BACKUP $CONFIG $EXCLUDE $ROOT/ $REMOTE/"
$CMD
