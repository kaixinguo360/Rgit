#!/bin/bash
#i:Run a cmd on remote repository
#u:Usage: rgit run <cmd>

ROOT=$(traverse $CURRENT) || exit
RSYNC=$ROOT/.rsync

REMOTE=$(cat $RSYNC/remote) || exit

# Run Cmd
if [ "${REMOTE##*:}" == "$REMOTE" ];then
    cd $REMOTE
    $@
else
    R_HOST=${REMOTE%%:*}
    R_PATH=${REMOTE##*:}
    CMD="ssh $R_HOST -t bash -ic '(cd $R_PATH;$@)'"
    echo "$CMD"
    $CMD
fi

