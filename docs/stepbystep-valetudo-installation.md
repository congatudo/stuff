
# Step by step guideline for Windows users
This guide pretends to get Valetudo server inide you conga using [this](https://github.com/adrigzr/Valetudo) Fork on github.
We are going to learn how to build the project and deploy it in the robot. We are not going to flash a new firmware.

## Sumary
1. [Requirements](#Requirements)
2. [Install from a Windows 10](#Install%20from%20a%20Windows%2010)
    - [Node installation](#Node%20installation)
    - [Get Valetudo](#Get%20Valetudo)
    - [Installing dependencies](#Installing%20dependencies)
    - [Run Valetudo for the first time](#Run%20Valetudo%20for%20the%20first%20time)
    - [Editing configuration file](#Editing%20configuration%20file)
    - [Run Valetudo in Windows (optional)](#Run%20Valetudo%20in%20Windows%20(optional))
    - [Build the server](#Build%20the%20server)
    - [Deploy Valetudo](#Deploy%20Valetudo)
4. [FAQ](#FAQ)

## Requirements
- A conga already connected to a wifi network
- Node (>v16) and npm(>v7) installed
- Get access to your conga via ssh or adb
- All the steps are going to happen from a windows PC

## Install from a Windows 10
### Node installation
Install Node from the current version tab following the official web, getting the msi executable from [here](https://nodejs.org/en/download/current/).

### Get Valetudo
From github you can [clone](https://github.com/adrigzr/Valetudo.git) the repo or just download a [zip file](https://github.com/adrigzr/Valetudo/archive/refs/heads/feature-conga.zip) and uncompress it somewhere.

### Installing dependencies
Go to the root path of the folder you already uncompressed or clone the project. We need to go to this path in a powershell window, so clicking in an empty space of the window with right button and shift key at the same time, you'll be prompto for an option menu where you can choice the option "Open Powershell window here", you are able to open a powershell window in the same path.
In here, firstly be sure you have installed node and npm with correct versions (node >=v16 and npm >=v7)
```bash
$> node -v
$> npm -v
```
After that, install dependencies running
```bash
$> npm install
```
You'll get some warnings, but no errors.

### Run Valetudo for the first time
This step is needed to get the very first version of our configuration file.
```bash
$> cd backend/
$> npm run start
```
An error will prompt and Valetudo will exit, but it should generated a new configuratioin file under the path: `C:\Users\USER\AppData\Local\Temp\valetudo_config.json`

### Editing configuration file
Copy this `C:\Users\USER\AppData\Local\Temp\valetudo_config.json` file into a saved folder and open it with some editing tool (visual studio code, notepad++, sublime, notepad, etc...). This json file has multiple options. edit the implementation to `CecotecCongaRobot`
```json
...
"robot": {
"implementation": "CecotecCongaRobot",
"implementationSpecificConfig": {
"ip": "127.0.0.1"
}
...
```

#### Run Valetudo in Windows (optional)
If you would like to run Valetudo in Windows locally, easy, just create an environment variable pointing to the valetudo config file path, and run again:
```bash
$> $env:VALETUDO_CONFIG_PATH="C:\path\to\valetudo\config\json\file"
$> cd backend
$> npm run start
```
Navigate to your localhost [localhost](http://localhost/) and you will be able to see Valetudo running (with no one Conga connected yet). To exit, just CTRL+C in the powershell session.

### Build the server
After that, we can build the program to get the binary(program) who is gonna run in the conga robot.
```bash
$> cd backend/
$> npm run build
$> cd ../build/armv7
```
There you'll find a file named "valetudo" . This is your kind binary. It is time to deploy both files (binary and configuration) to the conga.

### Deploy Valetudo
Firstly, try to access your conga via ssh with Powershell, you can check [here](https://gitlab.com/freeconga/stuff/-/blob/master/docs/rooting-conga.md) to understand how to overpass the password or (even better) update it. You can check your conga IP by looking in your router.
```bash
$> ssh root@192.168.X.Y
$> mkdir /mnt/UDISK/valetudo
$> exit
```
Save both files (binary and configuration) in an empty folder. Open this folder from powershell (by clicking shift+right mouse button, under an option in the menu).
```bash
$> cd /path/to/the/fólder/with/valetudo/and/configuration
$> scp -r . root@192.168.X.Y:/mnt/UDISK/valetudo
$> ssh root@192.168.X.Y
$> vi /etc/init.d/valetudo
```
Press 'i' in the keyboard and paste (right click) this script
```bash
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
After this, press the ESC key and type ':wq' and enter to save the new file. Now, you are able to change the host Cecotec to your Valetudo server. Enable to run Valetudo at startup and reboot the device.
```bash
$> echo "127.0.0.1 cecotec.das.3irobotix.net cecotec.download.3irobotix.net cecotec.log.3irobotix.net cecotec.ota.3irobotix.net eu.das.3irobotics.net eu.log.3irobotics.net eu.ota.3irobotics.net" >> /etc/hosts
$> /etc/init.d/valetudo enable
$> reboot
```
Wait some seconds till the Conga startup again (a beep will sound) and you should have Valetudo running on your robot, navigate to [yourcongaip](http://youcongaip) :tada:


## FAQ
Q: I get a `missing script` in the logs
A: Make sure you build the solution from the backend folder

Q: I get some error in the npm build command
A: Make sure the version you are running. 
- npm >= v7
- node >= v16