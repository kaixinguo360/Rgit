#!/bin/bash
#i:Check the given path
#u:Usage: rgit check <repo>

[ -z "$1" ] && {
print_help
exit 0
}

rsync --dry-run $1
