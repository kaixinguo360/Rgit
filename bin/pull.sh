#!/bin/bash
#i:Fetch from and integrate with another repository or a local branch
#u:Usage: rgit pull

ROOT=$(traverse $CURRENT) || exit
RSYNC=$ROOT/.rsync

REMOTE=$(cat $RSYNC/remote) || exit
CONFIG=$(cat $RSYNC/config) || exit

EXCLUDE="--exclude=.rsync"
if [ -f "$RSYNC/exclude" ];then
    EXCLUDE="--exclude-from=$RSYNC/exclude "$EXCLUDE
fi

BACKUP_PATH=$RSYNC/backup/$(date '+%Y/%m/%d/%H%M%S')
BACKUP="-b --backup-dir $BACKUP_PATH"

CMD="rsync $@ $BACKUP $CONFIG $EXCLUDE $REMOTE/ $ROOT/"
$CMD
