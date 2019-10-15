#!/bin/bash
#i:Create an empty RGit repository or reinitialize an existing one
#u:Usage: rgit init <remote>

REMOTE=$1
if [ "$REMOTE" = "" ];then
    echo "rgit: missing operand"
    print_help
    exit 1
fi

RSYNC=$CURRENT/.rsync
if [ -d "$RSYNC" ];then
    echo "rgit: cannot create directory ‘.rsync’: File exists"
    exit 1
fi

mkdir "$RSYNC"
echo "$REMOTE" > $RSYNC/remote
echo "-a -v -zz --delete" > $RSYNC/config

echo "" > $RSYNC/exclude
if [[ -f "$CURRENT/.gitignore" && "$(sed -n '/.rsync/'p $CURRENT/.gitignore)" = "" ]];then
    echo ".rsync" >> $CURRENT/.gitignore
fi

mkdir "$RSYNC/hooks"
touch "$RSYNC/hooks/pre-push.sample"
touch "$RSYNC/hooks/post-push.sample"
touch "$RSYNC/hooks/pre-pull.sample"
touch "$RSYNC/hooks/post-pull.sample"
touch "$RSYNC/hooks/pre-push-remote.sample"
touch "$RSYNC/hooks/post-push-remote.sample"
touch "$RSYNC/hooks/pre-pull-remote.sample"
touch "$RSYNC/hooks/post-pull-remote.sample"

echo "Initialized empty RGit repository in $RSYNC"
