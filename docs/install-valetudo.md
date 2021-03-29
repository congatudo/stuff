# How to install Valetudo in your Conga

[Valetudo](https://valetudo.cloud/) is a standalone binary which runs on rooted Vacuums and aims to enable the user to operate the robot vacuum without any Cloud Connection whatsoever.

There is no official support for Congas in Valetudo ecosystem. The following guide is highly experimental and unstable.

There are two ways of using Valetudo in your Conga:

1. Standalone. This will install and run Valetudo directly on your Conga.
2. Local Development Setup.

## Prerequisites

You need to be able to [access your Conga by SSH](./rooting-conga-3x90.md).

## Standalone

This procedure is still experimental
### 1. Install
- [`git`](https://git-scm.com/)
- [`npm`](https://www.npmjs.com/)
### 2. Clone a valid Valetudo repo
```
$ git clone https://github.com/adrigzr/Valetudo
```
### 3. Install dependencies
```
$ cd Valetudo
$ npm install
```
### 4. Create default configuration by running valetudo
```
$ npm run start
CTRL + C
```

On first launch, Valetudo will generate a default config file as `/tmp/valetudo_config.json`. Simply stop Valetudo using `CTRL + C` and edit the newly created file. Change the following lines:
```
{
  ...
  "robot": {
    "implementation": "CecotecCongaXXXX",
    "implementationSpecificConfig": {
      "ip": "127.0.0.1"
    }
    ...
}
```
If you would like to integrate Valetudo with Home Assistant, you could edit these lines too:
```
{...
 "mqtt": {
    "enabled": true,
    "server": "192.168.XX.YY",
    "port": "1883",
    "clientId": "valetudo",
    "username": "USER",
    "password": "PASS",
    "usetls": false,
    "ca": "",
    "clientCert": "",
    "clientKey": "",
    "qos": 0,
    "identifier": "robot",
    "topicPrefix": "valetudo",
    "autoconfPrefix": "homeassistant",
    "provideMapData": true,
    "homeassistantMapHack": true
  }
  ...
},
```
### 5. After that, you can build the binary file:
```
npm build
```

### 6. You should copy now the new valetudo binary file generated and the config file to a rooted conga
```
scp valetudo root@<your pc ip>:<path>  #In conga 3090 this path could be /mnt/UDISK/ or similar directory you created i.e. mkdir /mnt/UDISK/valetudo
scp /tmp/valetudo_config.json root@<your pc ip>:<path>  #In conga 3090 this path could be /mnt/UDISK/ or similar directory you created i.e. mkdir /mnt/UDISK/valetudo
```
### 7. Create a script file to export the enviroment variable and run the server at boot
```
ssh root@<your pc ip>
vi /etc/init.d/valetudo
```

add this script:
```
#!/bin/sh /etc/rc.common                                                                                                    
# File: /etc/init.d/valetudo
# Usage help: /etc/init.d/valetudo
# Example: /etc/init.d/valetudo start
START=85
STOP=99                                     
USE_PROCD=1                                                                                                                
PROG=/mnt/UDISK/valetudo/valetudo
CONFIG=/mnt/UDISK/valetudo/valetudo_config.json                                     
start_service() {                     
  procd_open_instance                 
  procd_set_param env VALETUDO_CONFIG_PATH=$CONFIG
  procd_set_param command $PROG    

  procd_set_param respawn ${respawn_threshold:-3600} ${respawn_timeout:-10} ${respawn_retry:-5}
  procd_close_instance                
}                                                                                                                          
shutdown() {                                                                                                            
  echo shutdown                                                                                                   
}
```
### 8. Edit hosts file in conga to point to valetudo server and reboot
```
$ ssh root@<conga ip>
# echo "<your pc ip> cecotec.das.3irobotix.net cecotec.download.3irobotix.net cecotec.log.3irobotix.net cecotec.ota.3irobotix.net eu.das.3irobotics.net eu.log.3irobotics.net eu.ota.3irobotics.net" >> /etc/hosts
#reboot
```

### 9. Check if webserver up and running
If you have your development server running you can access Valetudo WebServer in http://<ip conga>

### 10. Tips to add the integration into Home Assistant
- In Home Assistant (from now HA) configuration file:
```
mqtt:
  discovery: true
  discovery_prefix: homeassistant
```
- In order to get the map card, you can add [this](https://github.com/TheLastProject/lovelace-valetudo-map-card) addon with HACS.
For more info visit the valetudo official docs at https://valetudo.cloud/pages/integrations/home-assistant-integration.html

## Local Development Setup

### 1. Install prerequisites

1. [`git`](https://git-scm.com/)
2. [`npm`](https://www.npmjs.com/)

### 2. Clone our repository fork

```
$ git clone https://github.com/adrigzr/Valetudo
```

### 3. Install dependencies

```
$ cd Valetudo
$ npm install
```

### 4. Create default configuration by running valetudo

```
$ npm run start
CTRL + C
```

On first launch, Valetudo will generate a default config file as `local/config.json`. Simply stop Valetudo using `CTRL + C` and edit the newly created file. Change the following lines:

```
{
  ...
  "logLevel": "debug",
  "webserver": {
    "port": 8080
  },
  "model": {
    "type": "cecotec.conga.3490",
    "embedded": false
  },
  ...
}
```

Please note that Valetudo will replace the configuration with a default one if it fails to parse it correctly.

### 5. Verify configuration and run

```
$ npm run start
```

If your configuration is correct, Valetudo should now be working on your development host.

### 6. Configure your Conga to access your development server

Access your Conga and change the host file:

```
$ ssh root@<conga ip>
# echo "<your pc ip> cecotec.das.3irobotix.net cecotec.download.3irobotix.net cecotec.log.3irobotix.net cecotec.ota.3irobotix.net eu.das.3irobotics.net eu.log.3irobotics.net eu.ota.3irobotics.net" >> /etc/hosts
# reboot
```

Note: To temporarily revert this while needing to use the Conga App, you can comment out the line in /etc/hosts.

### 7. Access Valetudo WebServer

If you have your development server running you can access Valetudo WebServer in [http://localhost:8080](http://localhost:8080) or using your computer local network ip address.

## Sources

- [Building and Modifying Valetudo](https://valetudo.cloud/pages/development/building-and-modifying-valetudo.html)
