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

echo ".git" > $RSYNC/exclude
if [[ -f "$CURRENT/.gitignore" && "$(sed -n '/.rsync/'p $CURRENT/.gitignore)" = "" ]];then
    echo ".rsync" >> $CURRENT/.gitignore
fi

echo "Initialized empty RGit repository in $RSYNC"
