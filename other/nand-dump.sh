#!/usr/bin/env sh

echo -e "Starting NAND partitions dumping process ... \n"

# go to RAM storage
cd /tmp

# create dump folder
mkdir nand-dump
cd nand-dump

# generate list
ls -la /dev/by-name/ > list.txt

# dump all nand partitions
echo "    dumping nanda [boot-res] ..."
dd bs=4M if=/dev/nanda of=boot-res-nanda.img
echo "    dumping nandb [env] ..."
dd bs=4M if=/dev/nandb of=env-nandb.img
echo "    dumping nandc [boot] ..."
dd bs=4M if=/dev/nandc of=boot-nandc.img
echo "    dumping nandd [rootfs] ..."
dd bs=4M if=/dev/nandd of=rootfs-nandd.img
echo "    dumping nande [rootfs_data] ..."
dd bs=4M if=/dev/nande of=rootfs_data-nande.img
echo "    dumping nandf [private] ..."
dd bs=4M if=/dev/nandf of=private-nandf.img
echo "    dumping nandg [recovery] ..."
dd bs=4M if=/dev/nandg of=recovery-nandg.img
echo "    dumping nandh [misc] ..."
dd bs=4M if=/dev/nandh of=misc-nandh.img
echo "    dumping nandi [UDISK] ..."
dd bs=4M if=/dev/nandi of=UDISK-nandi.img

# done
echo -e "\nAll done!"
echo -e "Remember to copy the nand-dump folder somewhere else 
(e.g. adb pull /tmp/nand-dump) as it will be lost in the next reboot.\n\n"
