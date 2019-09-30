#!/bin/bash

FILE=$1
FLAG=$2

NUM=0

while read LINE
do
    if [ "${LINE%%:*}" = "#$FLAG" ];then
        echo "${LINE#*:}"
        NUM=$[$NUM+1]
    fi
    if [ "${LINE:0:1}" != "#" ];then
        break
    fi
done < $FILE

[ "$NUM" = 0 ] && exit 1
exit
