#!/bin/bash
#
# Script for sucking down videos from videolectures.net. Tested Oct 2009.
#
# Contact: Matt Tierney (tierney@cs.nyu.edu)
#
# Requires two arguments.
#
# ./thisfile.sh [VIDEOLECTURES.NET URL]
#
# Note: Run this script in screen or somewhere where you can just
# 'leave it alone' for a while, especially if a video lecture is long.
#
FILE=`echo $1 | cut -d'/' -f4`
WMVFILE=`echo $1 | cut -d'/' -f4`.wmv
AVIFILE=$FILE.avi
TEMPFILE="tierneymyvid"
wget -O $TEMPFILE $1
MMSADDR=`cat $TEMPFILE | grep "wmv" | gawk '{ print $10 }' | cut -d'"' -f2 | sed 's/http/mms/g'`
rm $TEMPFILE

# Take MMS stream addr and convert to WMV
#
mplayer -dumpfile $WMVFILE -dumpstream $MMSADDR

# convert WMV to AVI
#
# mencoder $WMVFILE -ovc copy -oac copy -o $AVIFILE
mencoder $WMVFILE -ofps 23.976 -ovc lavc -oac copy -o $AVIFILE

# Input: AVI file
# Output: mp4 (mpeg4) file
#
ffmpeg -i $AVIFILE -vcodec mpeg4 -acodec libfaac -ab 44100 -b 934000 -r 1000 $FILE.mp4

# Convert from video to tga (for motion tracking)
#
ffmpeg -i $FILE.mp4 $FILE_%09d.tga

#EOF