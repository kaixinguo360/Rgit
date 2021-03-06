#!/bin/bash
#i:Update remote refs along with associated objects
#u:Usage: rgit push

ROOT="$(traverse $CURRENT)" || exit
RSYNC="$ROOT/.rsync"

REMOTE="$(cat $RSYNC/remote)" || exit
CONFIG="$(cat $RSYNC/config)" || exit

EXCLUDE="--exclude=.rsync"
if [ -f "$RSYNC/exclude" ];then
    EXCLUDE="--exclude-from=$RSYNC/exclude $EXCLUDE"
fi

BACKUP_PATH=".rsync/backup/$(date '+%Y/%m/%d/%H%M%S')"
BACKUP="-b --backup-dir $BACKUP_PATH"

CMD="rsync $@ $BACKUP $CONFIG $EXCLUDE $ROOT/ $REMOTE/"

if [ -f "$RSYNC/hooks/pre-push" ];then
    PRE_CMD="$(cat $RSYNC/hooks/pre-push|grep -Ev '^$'|tr '\n' ';')"
fi
if [ -f "$RSYNC/hooks/pre-push-remote" ];then
    PRE_REMOTE_CMD="$(cat $RSYNC/hooks/pre-push-remote|grep -Ev '^$'|tr '\n' ';')"
fi
if [ -f "$RSYNC/hooks/post-push" ];then
    POST_CMD="$(cat $RSYNC/hooks/post-push|grep -Ev '^$'|tr '\n' ';')"
fi
if [ -f "$RSYNC/hooks/post-push-remote" ];then
    POST_REMOTE_CMD="$(cat $RSYNC/hooks/post-push-remote|grep -Ev '^$'|tr '\n' ';')"
fi

cd "$ROOT"
[ -n "$PRE_CMD" ] && { bash -ic "$PRE_CMD"||exit; }
[ -n "$PRE_REMOTE_CMD" ] && { $RGIT_ROOT/rgit run $PRE_REMOTE_CMD||exit; }
sh -c "$CMD"||exit
[ -n "$POST_CMD" ] && { bash -ic "$POST_CMD"||exit; }
[ -n "$POST_REMOTE_CMD" ] && { $RGIT_ROOT/rgit run $POST_REMOTE_CMD||exit; }
exit 0
