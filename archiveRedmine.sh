#!/bin/bash
if [ $# -lt 1 ];then
	echo "At least need one parameter to specifi the archive catalog!!!"
	exit 1
fi

#Then archive All the content in the ~/Downloads/dir
fileDir="$HOME/Downloads"
destDir="$Document/Realbom/Android/GMS_exp"

#if specific the two name shceme
if [ $# -eq 2 ];then
	fileName="$1-$2"
else
	fileName="$1"
fi

echo "The gms experience catalog is : $fileName "
echo "Starting archiving to $destDir/$fileName..."

#First create a new dir named by parameter
mkdir $destDir/$fileName

echo "Copying file to the dir"

cp -a $fileDir/* $destDir/$fileName/

echo "Deleting previous file on $fileDir"

rm -r $fileDir/*

echo "Archive done."
