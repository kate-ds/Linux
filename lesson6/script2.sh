#!/bin/bash

help(){
    cat << EOF
Script to create bash files in specified folder
Usage: $0 [file(s)] -d [folder]
Examples:
  $0 --help
  $0 file -d /home/ekaterina
EOF
}

d=0

while  [[ $# -gt 0 ]] ; do
    [[ -d $1  ]] && FOLDERS+=($1) && shift && continue

    case $1 in
        --help)
            help
            exit 0
            ;;
	-d)
	    d=$((d + 1))
	    shift
	    ;;
        -*|--*)
            ARGS+=($1)
            shift
        ;;
        *)
            FILES+=($1)
            shift
        ;;
    esac
done

if [[ d -ne 1 ]]
then
    echo "One -d should be provided"
    exit 1
fi

if [[ " ${FILES[@]} " =~ "/" ]]; then
    echo "Filename should not contain '/'"
    exit 1
fi

(( ${#FOLDERS[@]} == 0 )) && echo "Folders not specified" && exit 1
(( ${#FILES[@]} == 0 )) && echo "Files not specified" && exit 2

for FILE in ${FILES[@]}
do
    if [ -f "$FILE" ]; then
	echo "$FILE already exists."
	exit 0
    fi
    touch $FOLDERS/$FILE
    echo "Created file: $FOLDERS/$FILE"
    if [[ "$FILE" =~ ".sh" ]]; then
	chmod +x $FOLDERS/$FILE
	echo "Made $FILE executable"
    fi


done

exit 0