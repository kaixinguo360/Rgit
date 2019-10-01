#!/bin/bash
#i:List available subcommands and some concept guides.
#u:Usage: rgit help <command>

CMD=$1

cd bin
if [ "$CMD" = "" ];then # if

cat <<HERE
usage: rgit <command> [<args>] [--help] [-h]

These are common RGit commands used in various situations:

HERE

for FILE in $(ls -1)
do
    echo -en '   '${FILE%%.*}'\n'
    doc $FILE i|awk '{print "         "$0}'
done

cat <<HERE

See 'rgit help <command>' to read about a specific subcommand.
HERE

else # else

if [ ! -f "$CMD.sh" ];then
    echo "rgit: '$CMD' is not a rgit command. See '${0##*/} --help'.">&2
    exit 1
fi

doc $CMD.sh u && echo
doc $CMD.sh i && echo
doc $CMD.sh f && echo
echo "Rsync Git, version 0.0.1"

fi #fi

