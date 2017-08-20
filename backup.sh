#!/bin/bash

# mount backup drive
mount /dev/sdc2 /mnt/usbdrive/

# collect information on disk layout for recovery purposes
lsblk > /mnt/usbdrive/backup/disk-layout/lsblk.txt
blkid > /mnt/usbdrive/backup/disk-layout/blkid.txt
pvs > /mnt/usbdrive/backup/disk-layout/pvs.txt
vgs > /mnt/usbdrive/backup/disk-layout/vgs.txt
lvs > /mnt/usbdrive/backup/disk-layout/lvs.txt

# copy data to usbdrive via rsync
rsync --delete -aAXv --progress --log-file=/mnt/usbdrive/backup/logs/$(date +%Y%m%d_%T)_logfile.log --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} /* /mnt/usbdrive/backup/rsync-backup/

# take point in time tape archive
cd /mnt/usbdrive/backup/rsync-backup/
tar zcvf /mnt/usbdrive/backup/tar-files/thor-backupi-$(date +%Y%m%d-%T).tar .

# umount backup drive
cd /
sudo umount /mnt/usbdrive/
