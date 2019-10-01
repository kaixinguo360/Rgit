#!/bin/bash

function doc() {
    file=$1
    flag=$2

    num=0

    while read LINE
    do
        if [ "${LINE%%:*}" = "#$flag" ];then
            echo "${LINE#*:}"
            num=$[$num+1]
        fi
        if [ "${LINE:0:1}" != "#" ];then
            break
        fi
    done < $file

    [ "$num" = 0 ] && return 1
    return 0
}

function print_help() {
    doc $RGIT_ROOT/bin/$RGIT_CMD.sh u
    doc $RGIT_ROOT/bin/$RGIT_CMD.sh f
}

function traverse() {
    current=$1
    while [ true ]
    do
        if [ -d "$current/.rsync" ];then
            echo $current
            exit
        fi
        LAST=$current
        current=$(dirname $current)
        if [ "$current" = "$LAST" ];then
            echo "fatal: Not a rgit repository (or any of the parent directories)">&2
            exit 128
        fi
    done
}
