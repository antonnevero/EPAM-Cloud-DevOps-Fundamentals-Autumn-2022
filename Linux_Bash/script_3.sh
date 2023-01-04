#!/bin/bash

#####
# This is a script that will backup your directory to /home/$USER/backup

# The script requires two parameters:
# 1. The path to the directory where the copies of the files will be stored.
# 2. Path to the syncing  directory.
#####

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "You need to pass two parameters"
        echo "1. The path to the directory where the copies of the files will be stored."
        echo "2. Path to the syncing  directory."
fi

BACKUP_TO=$1
BACKUP_FROM=$2
MYLOG=$BACKUP_TO/mylog

#-------------Creating backup directory and  add timestapm to log-------------
if ! (mkdir $BACKUP_TO 2> /dev/null)
then
	echo "Directory already existed." >> $MYLOG
else
        echo "Creating directory." >> $MYLOG
fi
echo "Timestamp before work is done $(date +"%D %T")" >> $MYLOG


#----------------Copying files and add all results to the log
echo "Copying Files" >> $MYLOG
cp -v $BACKUP_FROM/* $BACKUP_TO >> $MYLOG
echo "Finished Copying Files" >> $MYLOG
echo "Timestamp after work is done $(date +"%D %T")" >> $MYLOG
