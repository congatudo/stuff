# Conga Vacuums Map Backup

This is a workaround about doing a map backup for your Conga robot.

The restoration of the map will be done with your no-go areas, if it is a pending or approved map, segments/rooms names and all related to map data.

## Compatible Models

This info was verified with these models:
- 5090

## Map Storage

The maps are stored in the directory `/mnt/UDISK/log`, `/mnt/UDISK` is a persistent storage across reboots. I can not confirm that it is persistent across updates.


### Files & Explanation

The files you need to save inside your `/mnt/UDISK/log` are:

```bash
carto_slam.data
customer_map_list_path.plan
first_hardware_unbunding_flag.ini
resume_data.info
scheme_data.info1640869826
unfinished_carto_slam.data
unfinished_data.info
```

You can also do a backup of the file `0_png.png` but it is regenerated if it is not present after a while.

Not sure if `scheme_data.info1640869826` can have another name...

`*.temp` files are normally logs. The conga generate many logs that `gzipped` later and those `gzipped` logs are probably are uploaded to the FTP.

## Workaround

### Making a backup

```bash
rm -rf /mnt/UDISK/log/*.temp /mnt/UDISK/log/*.gz
cp -R /mnt/UDISK/log /mnt/UDISK/log.backup.$(date +%s)
```

#### Remote backup

You can use ssh to make the backup with just one command:

```bash
ssh root@congaip "rm -rf /mnt/UDISK/log/*.temp /mnt/UDISK/log/*.gz && cp -R /mnt/UDISK/log /mnt/UDISK/log.backup.$(date +%s)"
```

### Restoring a Map

To restore you must replace your `log` folder with backup folder and reboot the conga.

```bash
rm -rf /mnt/UDISK/log
cp -R /mnt/UDISK/log.backup /mnt/UDISK/log
```

Remember to point to correct backup folder because we were putting in the name the timestamp of the backup.

#### Remote restoring

```bash
ssh root@congaip "rm -rf /mnt/UDISK/log && cp -R /mnt/UDISK/log.backup /mnt/UDISK/log"
```
