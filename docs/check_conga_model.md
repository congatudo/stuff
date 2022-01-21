## Segments

Looks like congas from 3290 have segments.

### Partially compatible

- 3090 -> No segments so probably in the future will be incompatible with new versions of Valetudo.

### Incompatible models at this moment

- 1000 series
- 2000 series

## Conga sysProducts

```
3090 sysProduct=CECOTECCRL20A
3290 sysProduct=CECOTECCRL20D
3490 sysProduct=CECOTECCRL20D
3690 sysProduct=CECOTECCRL20S
4090 sysProduct=CECOTECCRL300
4690 sysProduct=CECOTECCRL300
5090 sysProduct=CECOTECCRL30S
5490 sysProduct=CECOTECCRL30S
```

## All ini files

```
/etc/sysconf/specail_hwdrivers.ini
/etc/sysconf/sysConfig.ini
/etc/sysconf/sysVersion.ini
/mnt/UDISK/log/first_hardware_unbunding_flag.ini
/mnt/UDISK/config/lidar_version.ini
/mnt/UDISK/config/followWall-icp-params.ini
/mnt/UDISK/config/motion_params.ini
/mnt/UDISK/config/sweep_record_config.ini
/mnt/UDISK/config/device_config.ini
/mnt/UDISK/config/pf-params.ini
/mnt/UDISK/config/hwdrivers.ini
/mnt/UDISK/config/log_config.ini
/mnt/UDISK/config/everest_config.ini
/mnt/UDISK/config/exploration-icp-params.ini
/mnt/UDISK/config/specail_hwdrivers.ini
/mnt/UDISK/config/icp-params.ini
/mnt/UDISK/config/logserver.ini
/mnt/UDISK/config/PackageInfoConfig.ini
/mnt/UDISK/config/history_map_config.ini
/mnt/UDISK/config/sysConfig.ini
/mnt/UDISK/config/booking_list_config.ini
/mnt/UDISK/config/net_config.ini
/mnt/UDISK/config/area.ini
/mnt/UDISK/config/algorithm_version.ini
/mnt/UDISK/config/app_log_config.ini
/mnt/UDISK/config/memory_map_specail.ini
/mnt/UDISK/config/auxctrl_restart.ini
/mnt/UDISK/config/device_comsumables.ini
/mnt/UDISK/config/stm32_version.ini
/mnt/UDISK/config/controller.ini
/rom/etc/sysconf/specail_hwdrivers.ini
/rom/etc/sysconf/sysConfig.ini
/rom/etc/sysconf/sysVersion.ini
```

## SysVersion by models

This will be the models and returned config by executing:
```bash
cat /etc/sysconf/sysVersion.ini
```

### 3290

```bash
[sysversion_Config] 
hardsysVersion=1.0.1 
sysVersion=S1.2.10 
sysCreateTime=1532053840 
sysProduct=CECOTECCRL20D 
sysVersionType=Release
```

### 3490

```bash
[sysversion_Config] 
hardsysVersion=1.0.1 
sysVersion=S1.2.10 
sysCreateTime=1532053840 
sysProduct=CECOTECCRL20D 
sysVersionType=Release
```

### 3890

```bash
[sysversion_Config]
hardsysVersion=1.0.2
sysVersion=S3.3.10
sysVersionCode=10
sysProduct=CECOTECCRL20S
sysSecondProduct=1001
sysCreateTime=1589524838
versionType=R
serverType=r
```

### 4090

```
[sysversion_Config]
hardsysVersion=1.0.1
sysVersion=S3.3.8
sysCreateTime=1527231363
sysProduct=CECOTECCRL300
sysVersionType=Release
```

### 4690

```bash
[sysversion_Config]
hardsysVersion=1.0.2
sysVersion=S3.4.8
sysVersionCode=8
sysProduct=CECOTECCRL300
sysSecondProduct=1001
sysCreateTime=1589524838
versionType=R
serverType=r
```

### 5090

```bash
[sysversion_Config]
hardsysVersion=1.0.1
sysVersion=S3.2.6
sysCreateTime=1527231363
sysProduct=CECOTECCRL30S
sysVersionType=Release
```

### 5490

```bash
[sysversion_Config]
hardsysVersion=1.0.1
sysVersion=S4.2.2
sysCreateTime=1527231363
sysProduct=CECOTECCRL30S
sysVersionType=Release
```

## Woraround

Shell functions to check if the model is compatible and get ini options

```bash
# Load src/lib/shell/check.sh
. "src/lib/shell/check.sh"

if is_compatible_valetudo_model; then
  echo "You can install freeconga valetudo fork"
else
  echo "Not compatible conga"
fi
```

These commands must be executed in the vacuum shell.
