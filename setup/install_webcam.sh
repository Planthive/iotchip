#!/bin/bash

# getting install location from script file location
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
export ROOT_DIR="$DIR"

 # Enable camera
if grep "start_x=1" /boot/config.txt ; then
	echo "Webcam is already in /boot/config.txt"
	sleep 1
else
	if grep "start_x=0" /boot/config.txt ; then
		sudo sed -i "s/start_x=0/start_x=1/g" /boot/config.txt
	else
		sudo echo "start_x=1" >> /boot/config.txt
	fi
	sudo echo "gpu_mem=128" >> /boot/config.txt
	# sudo echo "disable_camera_led=1" >> /boot/config.txt 
	echo "Webcam activated (reboot required)"
fi

# [DEPRECATED]
# Download camera 
# echo "Starting download and install..."
# sleep 1
# cd "$ROOT_DIR/lib"
# git clone https://github.com/silvanmelchior/RPi_Cam_Web_Interface.git
# cd "$ROOT_DIR/lib/RPi_Cam_Web_Interface"
# chmod u+x *.sh
# echo "Launching RPi Web Cam Interface..."
# sleep 1
# ./RPi_Cam_Web_Interface_Installer.sh install

# [ALTERNATIVE]
# Alternative, install OpenCV and use picamera
# if false ; then
# 	echo "Starting OpenCV download and install..."
# 	source ~/.profile
# 	sudo dpkg --configure -a
# 	echo "updating package..."
# 	sudo apt-get install build-essential cmake pkg-config
# 	sudo apt-get install libjpeg8-dev libtiff4-dev libjasper-dev libpng12-dev
# 	sudo apt-get install libgtk2.0-dev
# 	sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
# 	sudo apt-get install libatlas-base-dev gfortran
	# incomplete, for full code :
	# http://www.pyimagesearch.com/2015/02/23/install-opencv-and-python-on-your-raspberry-pi-2-and-b/
	# http://www.pyimagesearch.com/2015/03/30/accessing-the-raspberry-pi-camera-with-opencv-and-python/
# fi