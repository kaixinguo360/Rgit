#!/bin/bash
#i:Clone a repository into a new directory
#u:Usage: rgit clone <repo> [<dir>]

REMOTE=$1
DIR=$2

if [ "$REMOTE" = "" ];then
    echo "rgit: missing operand"
    print_help
    exit 1
fi
if [ "${REMOTE%?}/" = "$REMOTE" ];then
    REMOTE=${REMOTE%?}
fi

if [ "$DIR" = "" ];then
    DIR=${REMOTE##*/}
fi
if [ "${DIR%?}/" = "$DIR" ];then
    DIR=${DIR%?}
fi

# Get Absolute Path
cd $CURRENT
DIR=$(realpath $DIR)
if [ -z "$(echo "$REMOTE"|grep ':')" ];then
    REMOTE=$(realpath $REMOTE)
fi
cd $RGIT_ROOT

# Check Target Directory
if [[ -d "$DIR" && "$(ls -A $DIR|wc -w)" != 0 ]];then
    echo "fatal: destination path '$DIR' already exists and is not an empty directory."
    exit 1
else
    mkdir -p $DIR
fi

# Clone Repository
echo "Cloning into '${DIR##*/}'..."
echo "Remote: $REMOTE"
echo "Local:  $DIR"
cd $DIR
$RGIT_ROOT/rgit init $REMOTE
$RGIT_ROOT/rgit pull
