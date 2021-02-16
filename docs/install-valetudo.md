# How to install Valetudo in your Conga

[Valetudo](https://valetudo.cloud/) is a standalone binary which runs on rooted Vacuums and aims to enable the user to operate the robot vacuum without any Cloud Connection whatsoever.

There is no official support for Congas in Valetudo ecosystem. The following guide is highly experimental and unstable.

There are two ways of using Valetudo in your Conga:

1. Standalone. This will install and run Valetudo directly on your Conga.
2. Local Development Setup.

## Prerequisites

You need to be able to [access your Conga by SSH](./rooting-conga-3x90.md).

## Standalone

This method is currently untested and will be documented in the future.

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
