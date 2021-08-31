# How to install Valetudo in your Conga

[Valetudo](https://valetudo.cloud/) is a standalone binary which runs on rooted Vacuums and aims to enable the user to operate the robot vacuum without any Cloud Connection whatsoever.

There is no official support for Congas in Valetudo ecosystem. The following guide is highly experimental and unstable.

There are two ways of using Valetudo in your Conga:

1. Standalone. This will install and run Valetudo directly on your Conga.
2. Local Development Setup.
3. Dockerize.

## Prerequisites

You need to be able to [access your Conga by SSH](./rooting-conga-3x90.md).

## Standalone

This procedure is still experimental
### 1. Install
- [`git`](https://git-scm.com/)
- [`npm`](https://www.npmjs.com/)
### 2. Clone a valid Valetudo repo on your local machine
```
$ git clone https://github.com/adrigzr/Valetudo
```
### 3. Install dependencies on your local machine
```
$ cd Valetudo
$ npm install
$ npm ci
$ npm run build_openapi_schema
$ npm run build --workspace=frontend
```
### 4. Create default configuration by running Valetudo on your local machine
```
$ cd backend
$ npm run start
CTRL + C
```

On first launch, Valetudo will generate a default config file as `/tmp/valetudo_config.json`. Simply stop Valetudo using `CTRL + C` and edit the newly created file. Change the following lines:
```
{
  ...
  "robot": {
    "implementation": "CecotecCongaRobot",
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
### 5. After that, you can build the binary file on your local machine
```
$ cd backend
$ npm run build
```

### 6. You should copy now the new Valetudo binary file generated and the config file on your local machine to a rooted conga
```
scp ./build/armv7/valetudo root@<your pc ip>:<path>  #In conga 3090 this path could be /mnt/UDISK/ or similar directory you created i.e. mkdir /mnt/UDISK/valetudo
scp /tmp/valetudo_config.json root@<your pc ip>:<path>  #In conga 3090 this path could be /mnt/UDISK/ or similar directory you created i.e. mkdir /mnt/UDISK/valetudo
```
### 7. Create a script file to export the enviroment variable and run the server at boot in your robot
```
ssh root@<your conga ip>
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
### 8. Edit hosts file in your conga robot to point to Valetudo server and reboot
```
$> ssh root@<conga ip>
$> echo "<your home assistant ip> cecotec.das.3irobotix.net cecotec.download.3irobotix.net cecotec.log.3irobotix.net cecotec.ota.3irobotix.net eu.das.3irobotics.net eu.log.3irobotics.net eu.ota.3irobotics.net cecotec-das.3irobotix.net cecotec-log.3irobotix.net cecotec-upgrade.3irobotix.net cecotec-download.3irobotix.net" >> /etc/hosts
$> /etc/init.d/valetudo enable
$> reboot
```

### 9. Check if webserver is up and running in your robot
If you have your development server running you can access Valetudo WebServer in http://<ip conga>

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
$ npm ci
$ npm run build_openapi_schema
$ npm run build --workspace=frontend
```

### 4. Create default configuration by running valetudo

```
$ cd backend
$ npm run start
CTRL + C
```

On first launch, Valetudo will generate a default config file as `/tmp/valetudo_config.json`. Simply stop Valetudo using `CTRL + C` and edit the newly created file. Change the following lines:
```
{
  ...
  "robot": {
    "implementation": "CecotecCongaRobot",
    "implementationSpecificConfig": {
      "ip": "127.0.0.1"
    }
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
# echo "<your home assistant ip> cecotec.das.3irobotix.net cecotec.download.3irobotix.net cecotec.log.3irobotix.net cecotec.ota.3irobotix.net eu.das.3irobotics.net eu.log.3irobotics.net eu.ota.3irobotics.net cecotec-das.3irobotix.net cecotec-log.3irobotix.net cecotec-upgrade.3irobotix.net cecotec-download.3irobotix.net" >> /etc/hosts
# reboot
```

Note: To temporarily revert this while needing to use the Conga App, you can comment out the line in /etc/hosts.

### 7. Access Valetudo WebServer

If you have your development server running you can access Valetudo WebServer in [http://localhost:8080](http://localhost:8080) or using your computer local network ip address.


## Dockerize
### Use the dockerhub image
Firstly, get a valid valetudo config file in https://github.com/Hypfer/Valetudo/blob/\<release\>/backend/lib/res/default_config.json?raw=true
At editing time, the newest release is 2021.08.0
Then, you are able to just run the dockerhub image
```
sudo docker run --name valetudo -p 8081:8081 -p 4010:4010 -p 4030:4030 -p 4050:4050 -v $(pwd)/valetudo.json:/etc/valetudo/config.json -v valetudo_data:/data --name valetudo adrigzr/valetudo-conga:alpine-latest
```


## FAQ

1. I have Valetudo up and running but any robot is found
```
Check if hosts file in the robot is already edited.
Ping to a one of the cecotec cloud server instances to check if it reaches the conga ip, i.e.:
ping cecotec.das.3irobotix.net
```

2. I try to run a dockerize Valetudo server in my Raspberry server with Raspbian, but I got an error
```
Check this: https://www.gitmemory.com/issue/Koenkk/zigbee2mqtt/7662/852985841
```

3. Integrate it in Home Assistant
- If you have a Home Assistant instance, you may try the [valetudo addon](https://github.com/txitxo0/valetudo-addon)
- If you preffer to stay with a standalone installation:
  - Prerrequesite: Having a mqtt server already integrated in HA.
  - In Home Assistant configuration file:
    ```
    mqtt:
      discovery: true
      discovery_prefix: homeassistant
    ```
  - In order to get the map card, you can add [this](https://github.com/TheLastProject/lovelace-valetudo-map-card) addon with HACS.
For more info visit the valetudo official docs at https://valetudo.cloud/pages/integrations/home-assistant-integration.html
## Sources

- [Building and Modifying Valetudo](https://valetudo.cloud/pages/development/building-and-modifying-valetudo.html)
