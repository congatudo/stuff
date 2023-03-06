#!/bin/ash
# $1: plan suffix. For instance, if map file is customer_map_list_path.plan.abajo,
# and MAPS_FILE_PREFIX=customer_map_list_path.plan. , the suffix is abajo

MAPS_FOLDER=/mnt/UDISK/log
MAPS_FILE_PREFIX=customer_map_list_path.plan.

if [[ $# -eq 1 ]]; then
  if [[ -f $MAPS_FOLDER/$MAPS_FILE_PREFIX$1 ]]; then
    echo "Switching to map $1 in $MAPS_FOLDER"
    cp $MAPS_FOLDER/$MAPS_FILE_PREFIX$1 $MAPS_FOLDER/customer_map_list_path.plan
    echo "Rebooting robot services"
    /etc/init.d/robotManager stop
    kill -9 "$(pidof Monitor RobotApp log-server everest-server AuxCtrl)"
    /etc/init.d/robotManager start
    echo done
  else
    echo "Wrong map. Use $0 map with map being one of:"
    ls $MAPS_FOLDER/$MAPS_FILE_PREFIX* | sed "s#$MAPS_FOLDER/$MAPS_FILE_PREFIX##"
    exit 1
  fi
else
   echo "Wrong syntax. Use $0 map \nFor instance: $0 abajo"
fi
