#!/bin/sh
/etc/init.d/robotManager stop
kill -9 `pidof Monitor`
kill -9 `pidof RobotApp`
kill -9 `pidof AuxCtrl`
kill -9 `pidof everest-server`
kill -9 `pidof log-server`
