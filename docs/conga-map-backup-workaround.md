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

## Automating the map backup

If your conga looses its map every few days, a workaround could be to automate restoring the map every day using cron.

### Instructions

#### 1. Copy the backup script to `/mnt/UDISK/logmaps.sh`:

The backup script is available in this repo [../other/logmaps.sh](../other/logmaps.sh). Download to your computer and then transfer to the conga:

    user@yourcomputer:~# wget -O logmaps.sh https://raw.githubusercontent.com/freeconga/stuff/master/other/logmaps.sh
    user@yourcomputer:~# scp logmaps.sh root@<congaip>:/mnt/UDISK/logmaps.sh

Now, you need to make it executable:

    user@yourcomputer:~# ssh root@<congaip> 'chmod +x /mnt/UDISK/logmaps.sh'

TIP: Remember to change `<congaip>` to your actual conga IP

#### 2. Make your first backup

Just type in the command like to check if the script is runnig fine:

    root@yourcongahostname:~# /mnt/UDISK/logmaps.sh
    Making maps backup to /mnt/UDISK/log_backup

#### 3. Write a cron task to be run each day

Type `crontab -e` in the command line so we can automate restoring the map each day. Enter this two lines (the first one is just one comment):

    # Restore conga maps.
    30 11 * * * /mnt/UDISK/logmaps.sh restore


TIP: Remember that each time the conga map is restored, the conga services will be restarted, so it will make a beep like everytime the conga is booting. Don't set the restore time for an hour that you will be sleeping.

TIP: Type `date` to find out the time of your conga, probably the hour is not the same that your country. Congas usually think they are still are on china so the configured time won't match your local time. Read next step to fix that.


#### 4. Activate cron daemon

It seems that the cron daemon is not enabled by default (at least it wasn't enabled in my 3090). To enable the cron daemon you should type:

    root@yourcongahostname:~# /etc/init.d/cron enable

Now your cron task will be executed at the local time of the robot. To know the time of your conga just enter `date` in your conga command line or if you want to know the UTC time type `date -u`. Remember that by default the congas are using some chinese timezone were they were born. You can change the default timezone for the more universal UTC if you modify the `option timezone ??????` to `option timezone UTC` in the file `/etc/config/system`. For reference this is how I have mine (you can change the hostname or NTP servers if you want).

    config system
            option hostname babosa
            option timezone UTC

    config timeserver ntp
            list server 0.openwrt.pool.ntp.org
            list server 3.es.pool.ntp.org
            option enable 1
            option enable_server 0
