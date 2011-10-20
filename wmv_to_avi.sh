#!/bin/bash

WMVFILE=
AVIFILE=

usage()
{
cat <<EOF
usage: $0 options

This script converts WMV file to AVI

OPTIONS:
   -h    Show this message
   -i    Input file (should be WMV)
   -o    Output file (should be AVI)
EOF
}

while getopts "hi:o:" OPTION
do
  case $OPTION in
      h)
	  usage
	  exit 1
	  ;;
      i)
	  WMVFILE=$OPTARG
	  ;;
      o)
	  AVIFILE=$OPTARG
	  ;;
      ?)
	  usage
	  exit
  esac
done

if [[ -z $WMVFILE ]] || [[ -z $AVIFILE ]]
then
    usage
    exit 1
fi

mencoder $WMVFILE -ofps 23.976 -ovc lavc -oac copy -o $AVIFILE

echo Done.

# EOF