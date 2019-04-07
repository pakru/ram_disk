#!/bin/bash

USER_NAME="pavel"
RAM_DISK_SIZE="2G"
RAM_DISK_PATH=/mnt/ramdisk
RAM_DISK_BACKUP_PATH=/home/$USER_NAME/RAM_DISK_DATA
LOG_FILE="ramdisk.log"

if (( EUID != 0 )); then
   echo "You must be root to do this." 1>&2
   exit 100
fi

if [ ! -d "$RAM_DISK_PATH" ]; then
    echo "Creating RAM disk folder"
    mkdir $RAM_DISK_PATH
fi


if [ ! -d "$RAM_DISK_BACKUP_PATH" ]; then
    echo "Creating RAM disk backup folder" 
    mkdir $RAM_DISK_BACKUP_PATH
fi

echo "Mounting RAM disk..."
mount -t tmpfs -o rw,size=$RAM_DISK_SIZE tmpfs $RAM_DISK_PATH
echo "Sync from FS..."
rsync -avh $RAM_DISK_BACKUP_PATH/ $RAM_DISK_PATH
chown -Rf $USER_NAME $RAM_DISK_PATH


# sync to fs
#rsync -avh --delete --recursive --force /mnt/ramdisk/ /var/ramdisk-backup/
