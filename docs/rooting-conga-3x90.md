# Rooting Cecotec Conga 3x90 (x = 2, 3, 4, 5, 6, 7)

Good news for you: this particular model comes **already rooted from factory**. Here are the steps to get access to it.

## Requirements

* a USB to microUSB cable
* a computer with ADB installed
* a Conga 3x90 (of course!)

## Procedure

1. Check that you have ADB tools installed and working in your computer (you can follow [this guide](https://www.xda-developers.com/install-adb-windows-macos-linux/))

2. Connect the USB cable to the Conga's frontal USB port

	![frontal usb port](frontal-usb-port.jpg)

3. Open a terminal or console and execute the following command:

	> adb shell

You should see something like this:

![Tina-Linux](tina-linux.png)

## Things you can do now
* Change the password (to something non-default and secure)
* Add certificates to access via ssh without passwords
* Sniff network traffic
* Investigate all **the stuff** ... 😍
