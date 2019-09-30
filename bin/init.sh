#!/bin/bash
#i:Create an empty Rgit repository or reinitialize an existing one
#u:Usage: rgit init <remote>

REMOTE=$1
if [ "$REMOTE" = "" ];then
    echo "rgit: missing operand"
    lib/doc.sh $0 u
    lib/doc.sh $0 f
    exit 1
fi

RSYNC=$CURRENT/.rsync
if [ -d "$RSYNC" ];then
    echo "rgit: cannot create directory ‘.rsync’: File exists"
    exit 1
fi

mkdir "$RSYNC"
echo "$REMOTE" > $RSYNC/remote
echo "-a -v -zz" > $RSYNC/config

echo ".git" > $RSYNC/exclude
if [[ -f "$CURRENT/.gitignore" && "$(sed -n '/.rsync/'p $CURRENT/.gitignore)" = "" ]];then
    echo ".rsync" >> $CURRENT/.gitignore
fi

echo "Initialized empty Git repository in $RSYNC"
