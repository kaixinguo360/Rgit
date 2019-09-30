#!/bin/bash
#i:List available subcommands and some concept guides.
#u:Usage: rgit help <command>

CMD=$1

cd $(dirname $0)
if [ "$CMD" = "" ];then # if

cat <<HERE
usage: rgit <command> [<args>] [--help] [-h]

These are common RGit commands used in various situations:

HERE

for FILE in $(ls -1)
do
    echo -en '   '${FILE%%.*}'\n'
    ../lib/doc.sh $FILE i|awk '{print "         "$0}'
done

cat <<HERE

See 'rgit help <command>' to read about a specific subcommand.
HERE

else # else

if [ ! -f "$CMD.sh" ];then
    echo "rgit: '$CMD' is not a rgit command. See '${0##*/} --help'.">&2
    exit 1
fi

../lib/doc.sh $CMD.sh u && echo
../lib/doc.sh $CMD.sh i && echo
../lib/doc.sh $CMD.sh f && echo
echo "Rsync Git, version 0.0.1"

fi #fi

