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

RSYNC_DIR=$CURRENT/.rsync
if [ -d "$RSYNC_DIR" ];then
    echo "rgit: cannot create directory ‘.rsync’: File exists"
    exit 1
fi

mkdir "$RSYNC_DIR"
echo "$REMOTE" > $RSYNC_DIR/remote
