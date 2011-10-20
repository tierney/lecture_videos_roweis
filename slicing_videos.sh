#!/bin/bash 

FILE=

usage()
{
cat <<EOF
usage: $0 options

This script slices videos by IFRAME.

2009 10 30 : Takes video. Outputs iframes with ffprobe.

OPTIONS:
   -h    Show this message
   -i    Input file
EOF
}
while getopts "hi:" OPTION
do
    case $OPTION in
	h) 
	    usage
	    exit 1
	    ;;
	i)
	    FILE=$OPTARG
	    ;;
	?)
	    usage
	    exit
    esac
done

if [[ -z $FILE ]]
then
    usage
    exit 1
fi

ffprobe -show_frames $FILE | grep 'pict_type=I' -B 2 -A 15

echo Done.

# EOF