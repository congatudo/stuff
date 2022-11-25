#!/bin/ash
# $1: backup or restore


BACKUP_FOLDER=/mnt/UDISK/log_backup
RESTORE_FOLDER=/mnt/UDISK/log

backup()
{
  if [ ! -d "$BACKUP_FOLDER" ]; then
    mkdir -p $BACKUP_FOLDER
    echo "Created backup directory in $BACKUP_FOLDER"
  fi
  echo "Making maps backup to $BACKUP_FOLDER"
  /bin/cp -R $RESTORE_FOLDER/* $BACKUP_FOLDER/
  /bin/rm -rf $BACKUP_FOLDER/*.temp
  /bin/rm -rf $BACKUP_FOLDER/*.txt.gz
  /bin/rm -rf $BACKUP_FOLDER/*.log.gz
  sleep 1
}

restore()
{
  echo "Restoring maps from $RESTORE_FOLDER"
  /bin/cp -R  $BACKUP_FOLDER/* $RESTORE_FOLDER/
  echo "Rebooting robot services"
  /etc/init.d/robotManager stop
  kill -9 "$(pidof Monitor RobotApp log-server everest-server AuxCtrl)"
  /etc/init.d/robotManager start
}

if [ "$1" = "backup" ]; then
  backup
elif [ "$1" = "restore" ]; then
  restore
else
  echo -e "Wrong syntaxis. Usage examples:\n    ./logmaps.sh backup\n    ./logmaps.sh restore\n"
  exit 1
fi
