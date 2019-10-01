#!/bin/bash

## Set Static Variables ##
GIT_URL="https://github.com/kaixinguo360/Rgit.git"
LOCAL="/usr/local"
if [ -n "$PREFIX" ];then
    LOCAL=$PREFIX
fi
BIN=$(realpath $LOCAL/bin)

## Read Input ##
LOCATION=$1
if [ -z "$LOCATION" ];then
    LOCATION=$LOCAL
fi
LOCATION=$(realpath $LOCATION/rgit)

## Start Install ##
# Clone From Git Repository
CMD_CLONE="git clone $GIT_URL $LOCATION"

# Clear Bin
CMD_CLEAR="rm -f $BIN/rgit"

# Create Soft Link
CMD_LINK="ln -s $LOCATION/rgit $BIN/rgit"

# Run $CMD
echo $CMD_CLONE
$CMD_CLONE || { echo "An error occured, stop install.";exit 1; }
echo $CMD_CLEAR
$CMD_CLEAR || { echo "An error occured, stop install.";exit 1; }
echo $CMD_LINK
$CMD_LINK || { echo "An error occured, stop install.";exit 1; }

# Install Success
cat << HERE

RGit has been installed to $LOCATION
See 'rgit help' to read help info.
HERE

