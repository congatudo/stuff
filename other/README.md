# Other stuff

Anything than docs or code should go here...

## TOOLS
* Script to dump the NAND contents inside the Conga itself (models 3290, 3390, 3490 & 3790)
	* [nand-dump.sh](nand-dump.sh)
	* you'll need to [get access to your Conga](../docs/rooting-conga-3x90.md) first
* Script to donwload and compile ADB 1.32 (useful for RasberryPi-Jessie e.g.)
	* [adb_1.32_gen.sh](adb_1.32_gen.sh)
* Script to backup and restore maps
	* [logmaps.sh](logmaps.sh)
* Script to select a map manually. 
	* First use the app to select the map, and copy the file /mnt/UDISK/log/customer_map_list_path.plan to /mnt/UDISK/log/customer_map_list_path.plan.XXX, for instance,  /mnt/UDISK/log/customer_map_list_path.plan.abajo, /mnt/UDISK/log/customer_map_list_path.plan.primeraplanta, ... Do it for all your maps. 
	* Then, select a map using the script as ./switchmap.sh abajo o ./switchmap.sh primeraplanta 
	* [switchmap.sh](switchmap.sh)
