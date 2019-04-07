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

echo "Sync data to FS"
rsync -avh --delete --recursive --force $RAM_DISK_PATH/ $RAM_DISK_BACKUP_PATH

echo "Unmount RAM disk"
umount $RAM_DISK_PATH

# sync to fs
#rsync -avh --delete --recursive --force /mnt/ramdisk/ /var/ramdisk-backup/
