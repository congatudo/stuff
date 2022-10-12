#!/bin/ash
# $1: backup or restore


BACKUP_FOLDER=/mnt/UDISK/log_backup
RESTORE_FOLDER=/mnt/UDISK/log

backup()
{
	echo "Creando carpeta de backup $BACKUP_FOLDER"

	mkdir -p $BACKUP_FOLDER
	sleep 1
	echo "Realizando copia a $BACKUP_FOLDER"
	/bin/cp -R $RESTORE_FOLDER/* $BACKUP_FOLDER/
	/bin/rm -rf $BACKUP_FOLDER/*.temp
	/bin/rm -rf $BACKUP_FOLDER/*.txt.gz
	/bin/rm -rf $BACKUP_FOLDER/*.log.gz
	sleep 1
	echo "Listo

Hasta la próxima
"
}

restore()
{
	echo "Restaurando archivos a $RESTORE_FOLDER"
	sleep 1
	/bin/cp -R  $BACKUP_FOLDER/* $RESTORE_FOLDER/
	sleep 1
	echo "Reiniciando servicios del robot" 
	/etc/init.d/robotManager stop
	sleep 1
	kill -9 $(pidof Monitor)
	kill -9 $(pidof RobotApp)
	kill -9 $(pidof log-server)
	kill -9 $(pidof everest-server)
	kill -9 $(pidof AuxCtrl)
	sleep 1
	/etc/init.d/robotManager start
	echo "Listo

Hasta la próxima
"
}

if [ "$1" = "backup" ]; then
    echo "log folder Backup"
    backup
else
    if [ "$1" = "restore" ]; then
        echo "log folder Restore"
        restore
    else
		echo "introduce logmaps.sh backup    o    logmaps.sh restore"
        exit 1
    fi
fi
