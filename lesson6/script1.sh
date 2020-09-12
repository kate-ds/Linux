#!/bin/bash

OPTIONS=w
LONGOPTS=write,help

! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    exit 2
fi

eval set -- "$PARSED"

write=0 help=0

while true; do
    case "$1" in
 -w|--write)
     write=1
     shift
     ;;
 --help)
     help=1
     shift
     ;;
 --)
     shift
     break
 ;;
 *)
     echo "Programming error"
     exit 3
     ;;
 esac
done

# echo "help: $help, write: $write, "

if [ $help -eq 1 ]
then
    echo "Arguments -w writes to file"
    exit
fi

if [ $write -eq 0 ]
then
	OUTPUT=$(sed -e '/^$/d; s/\(.*\)/\U\1/' $1)
	echo $OUTPUT
else
	sed -i '/^$/d; s/\(.*\)/\U\1/' $1
fi