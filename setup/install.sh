#!/bin/bash
# IoT Chip project version : 2.0

# clear

cat  << "EOF"
                        ,
                       dM
                       MMr
                      4MMML                  .
                      MMMMM.                xf
      .              "M6MMM               .MM-
       Mh..          +MM5MMM            .MMMM
       .MMM.         .MMMMML.          MMMMMh
        )MMMh.        MM5MMM         MMMMMMM
         3MMMMx.     'MMM3MMf      xnMMMMMM"
         '*MMMMM      MMMMMM.     nMMMMMMP"
           *MMMMMx    "MMM5M\    .MMMMMMM=
            *MMMMMh   "MMMMM"   JMMMMMMP
			              
                IoT Chip Install Pack
                         by
   _____    _                _____             _   _     
  |  ___|  | |              /  ___|           | | | |    
  | |__  __| | ___ _ __     \ `--. _   _ _ __ | |_| |__  
  |  __|/ _` |/ _ \ '_ \     `--. \ | | | '_ \| __| '_ \ 
  | |__| (_| |  __/ | | |   /\__/ / |_| | | | | |_| | | |
  \____/\__,_|\___|_| |_|   \____/ \__, |_| |_|\__|_| |_|
                                    __/ |                
                                   |___/
EOF

# getting install location from script file location
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
export ROOT_DIR="$DIR"
export SETUP_DIR="setup"
export RUN_DIR="run"
export BIN_DIR="bin"
cd "$ROOT_DIR/$SETUP_DIR"

# applying chmox +x to all install_xxx.sh files
chmod +x install_wifi.sh
chmod +x enable_interfaces.sh
chmod +x install_webcam.sh
chmod +x "../run/reboot.sh"
#chmod +x "../run/boxbgsvc.sh"

# Intro message
echo " Notes: "
echo " Before installing, make sure this host is connected to the Internet!"
# Choices menu
echo ""
echo " --------------------------INSTALL MENU---------------------------"
echo "  0- quit/exit"
echo ""
echo "  1- [DEPRECATED] Install Wifi dungle (required reboot)"
echo "  2- Install latest updates"
echo "    1- Install latest system updates (Recommended)"
echo "    2- [OPTIONAL] Install latest system upgrades (Optional)"
echo "    3- Install latest distribution upgrades (Recommended)"
echo "    4- [OPTIONAL] Install latest RPI updates (Optional)"
echo "  3- Install environment tools (required reboot) 
    . Python, Git, python-pip, NodeJS, npm"
echo "  4- Install required libraries
    . Adafruit, Adafruit RPi.GPIO, Adafruit_Python_MCP3008, Adafruit_PWM_PCA9685
    . python-crontab, Posters, i2ctools and python-smbus, fswebcam, pyudev, python-gtk2, 
	. Pusher, PythonPusherClient, websocket-client, npm pusher-client"
echo "  5- Init SystemCTRL processes "
echo "  6- Stop all SystemCTRL processes "
echo "  7- Enable interdaces, I2C and RTC clock (required reboot)"

echo ""
echo " -------------------------CONTROL MENU----------------------------"
echo " 8- [OPTIONAL] Wi-Fi Network Configuration (required reboot)"
echo ""
echo " -------------------------ADVANCED CONTROL------------------------"
echo " 9- [ADVANCED] GPIO execute modprobe commands"
echo ""
echo "  q- quit/exit"
echo " -----------------------------------------------------------------"
# Read action
read -p "Choose Action : " userAction
# Check action
if [ "$userAction" == "q" ] || [ "$userAction" == "-q" ] || [ "$userAction" == "0" ] ; then
	# exit script
	exit 0
fi
if (( userAction > 0 )) && (( userAction < 26 )) ; then
	if [ "$userAction" == 1 ] ; then
		echo "DEPRECATED"
		# read -p "Network ID: " networkId
		# read -p "Network Password: " networkPwd
		# cd "$ROOT_DIR/$SETUP_DIR"
		# sudo ./install_wifi.sh "$networkId" "$networkPwd" WPA WPA-PSK TKIP OPEN
	fi
	if [ "$userAction" == 2 ] ; then
		# prompt for sub action
		read -p "[1-4]: " userSubAction
		# run system updates script
		if [ "$userSubAction" == 1 ] ; then
			echo "Updating the host system... (this might take a while)"
			sleep 1
			sudo apt-get -y update
		fi
		if [ "$userSubAction" == 2 ] ; then
			echo "Upgrading the host system..."
			sleep 1
			sudo apt-get -y upgrade
		fi
		if [ "$userSubAction" == 3 ] ; then
			echo "Upgrading the host distribution..."
			sleep 1
			sudo apt-get -y dist-upgrade
			echo "Done dist-upgrade. Rebooting..."
			sleep 1
			sudo reboot
		fi
		if [ "$userSubAction" == 4 ] ; then
			echo "Upgrading the rpi... (this might take a while)"
			sleep 1
			sudo rpi-update
			echo "Done rpi-update. Rebooting..."
			sleep 1
			sudo reboot
		fi
	fi
	if [ "$userAction" == 3 ] ; then
		# run environment script
		echo "Setting up environment..."
		sleep 1
		# Python
		sudo apt-get -y install build-essential python-dev
		# Git
		sudo apt-get -y install git
		# pip
		sudo apt-get -y install python-pip 
		# NodeJSpython-pip
		sudo apt-get update
		sudo apt-get install -y nodejs
		sudo apt-get install -y npm
		# done
		echo "Done."
		sleep 1
		read -p "Press Enter to reboot... " pressanyk
		sudo reboot
	fi
	if [ "$userAction" == 4 ] ; then
		# run libraries script
		echo "Dowloading libraries to $ROOT_DIR/lib ..."
		sleep 1

       
         
	    # i2c tools
        cd "$ROOT_DIR/lib"
        sudo apt-get install -y python-smbus
        cd "$ROOT_DIR/lib"
        sudo apt-get install -y i2c-tools

		# RPi.GPIO
        cd "$ROOT_DIR/lib"
        sudo apt-get -y install python RPi.GPIO
        	# Adafruit_Python_MCP3008
        cd "$ROOT_DIR/lib"
        git clone https://github.com/adafruit/Adafruit_Python_MCP3008.git
        cd "$ROOT_DIR/lib/Adafruit_Python_MCP3008"
        sudo python setup.py install

		# Adafruit_PWM_PCA9685 (LED, fans, pump dimmer)
        cd "$ROOT_DIR/lib"
        sudo apt-get install git build-essential python-dev
        cd "$ROOT_DIR/lib"
        git clone https://github.com/adafruit/Adafruit_Python_PCA9685.git
        cd "$ROOT_DIR/lib/Adafruit_Python_PCA9685"
        sudo python setup.py install
        
        ## Install  Hygrometer Si7021
        cd "$ROOT_DIR/lib"
        git clone https://github.com/herm/Si7021
        cd "$ROOT_DIR/lib/Si7021"
        sudo python setup.py install
        
        ## Install waterlevel proximity
        cd "$ROOT_DIR/lib"
        git clone https://github.com/altosz/rpisensors.git
        cd "$ROOT_DIR/lib/rpisensors"
        sudo python setup.py install

        ## Install thermocouple watertemperature
        # start with dependencies
        cd "$ROOT_DIR/lib"
        sudo apt-get install -y build-essential libi2c-dev i2c-tools python-dev libffi-dev
        # install library
        sudo pip install smbus-cffi
        
        ## get mcp9600 python class
        cd "$ROOT_DIR/lib"
        git clone https://github.com/pimoroni/mcp9600-python
        cd "$ROOT_DIR/lib/mcp9600-python"
        sudo chmod +x install.sh
        sudo ./install.sh
        
        
        ## install SC18IS602B (convert I2C to SPI for TEC module) https://github.com/MLAB-project/pymlab
        # dependencies
        cd "$ROOT_DIR/lib"
        sudo apt-get install git python-setuptools python-smbus python-six python3-six 
        git clone https://github.com/MLAB-project/pymlab
        cd "$ROOT_DIR/lib/pymlab"
        sudo python setup.py develop
        
        # install Raspberry Pi access point
        sudo apt update && sudo apt --yes --force-yes install dnsmasq hostapd python3-dev python3-pip && sudo pip3 install pyaccesspoint
        
        # install wpaconfig for WiFi configuration
        cd "$ROOT_DIR/lib"
        git clone https://github.com/proxypoke/wpa_config.git
        cd "$ROOT_DIR/lib/wpa_config"
        sudo python setup.py install
        
        # move accesspoint config file to 
        cd "$ROOT_DIR"
        sudo cp conf/tmp/accesspoint.json /etc/accesspoint/accesspoint.json
        
        # immediately configure default wifi credentials
        # sudo wpa_config add -f BilboSchwaggings RodolpheSalis
        # sudo wpa_config make
        # sudo wpa_config add -f VOO-410404 KVBLNESD
        # sudo wpa_config make
        # sudo wpa_config add -f PlantHive rickandmorty
        # sudo wpa_config make
        
        # install flask for webserver
        sudo pip install flask

		# fswebcam
        cd "$ROOT_DIR/lib"
        sudo apt-get install -y fswebcam

		# pyudev for USB listener and Wifi
        cd "$ROOT_DIR/lib"
        sudo pip install pyudev

		# python gtk2 libs (glib)
        cd "$ROOT_DIR/lib"
        sudo apt-get install -y python-gtk2
        

        	# python-crontab
        cd "$ROOT_DIR/lib"
        # sudo wget https://pypi.python.org/packages/source/p/python-crontab/python-crontab-2.0.1.tar.gz
        # tar -xvzf python-crontab-2.0.1.tar.gz
        # sudo rm python-crontab-2.0.1.tar.gz
        cd "$ROOT_DIR/lib/python-crontab-2.0.1"
        sudo python setup.py install
    
    		# poster for multipart encoding
        cd "$ROOT_DIR/lib"
        sudo apt-get -y install python python-poster

	fi

        

        
    if [ "$userAction" == 5 ] ; then   
    

    
        
        # move /lib/service files to systemctl and enable/start them
        cd "$ROOT_DIR/lib"
        sudo cp service/init_PH.service /lib/systemd/system
        sudo cp service/wifi_page.service /lib/systemd/system
        sudo cp service/sunset.service /lib/systemd/system
        sudo cp service/app_send_json.service /lib/systemd/system
        sudo cp service/app_get_json.service /lib/systemd/system
        
        sudo chmod 644 /lib/systemd/system/init_PH.service
        sudo chmod 644 /lib/systemd/system/wifi_page.service
        sudo chmod 644 /lib/systemd/system/sunset.service
        sudo chmod 644 /lib/systemd/system/app_send_json.service
        sudo chmod 644 /lib/systemd/system/app_get_json.service
        
        sudo systemctl daemon-reload
        
        sudo systemctl enable init_PH.service
        sudo systemctl start init_PH.service
        
        sudo systemctl enable app_send_json.service
        sudo systemctl start app_send_json.service
        
        sudo systemctl enable app_get_json.service
        sudo systemctl start app_get_json.service

        # setup crontab commands and routines
        read_sensors=$(crontab -l | grep -q '/read_sensors.py' && echo "true" || echo "false")
        if [ "$read_sensors" == false ] ; then
            echo "Writing read_sensors.py to cron"
            (crontab -l ; echo "*/3 * * * * sudo python $ROOT_DIR/$BIN_DIR/read_sensors.py") | crontab
            echo "Cron updated"
        fi
		
        echo "Cron is ready."
        echo "executing crontab -l..."
        crontab -l
        read -p "Press Enter... " pressanyk
    fi

    if [ "$userAction" == 6 ] ; then   
    

    
        
        # move /lib/service files to systemctl and enable/start them
        cd "$ROOT_DIR/lib"
        
        

        
        sudo systemctl stop init_PH.service
        sudo systemctl stop app_send_json.service
        sudo systemctl stop app_get_json.service
        
        sudo rm /lib/systemd/system/init_PH.service 
        sudo rm /lib/systemd/system/wifi_page.service 
        sudo rm /lib/systemd/system/sunset.service 
        sudo rm /lib/systemd/system/app_send_json.service
        sudo rm /lib/systemd/system/app_get_json.service
        
        sudo systemctl daemon-reload

        
        
    fi


    if [ "$userAction" == 7 ] ; then
        # run sensors script
        cd "$ROOT_DIR/$SETUP_DIR"
        sudo ./enable_interfaces.sh        
    fi

    
    
    
	if [ "$userAction" == 8 ] ; then
		# prompt for wifi login
		networkProto="WPA"
		networkKeymgmt="WPA-PSK"
		networkPairwise="TKIP"
		networkAuthalg="OPEN"
		echo "Fill in new configuration. Defaults are marked with *"
		read -p "Network SSID: " networkId
		read -p "Network Password: " networkPwd
		read -p "Network Protocol: [RSN,WPA*]" networkProto
		read -p "Network Key Management: [WPA-PSK*,WPA-EAP]" networkKeymgmt
		read -p "Network Pairwise: [CCMP,TKIP*]" networkPairwise
		read -p "Network Auth Alorithm: [OPEN*,SHARED,LEAP]" networkAuthalg
		if [ "$networkProto" == "*" ] || [ -z "${networkProto// }" ] ; then 
			 export networkProto=WPA
		fi
		if [ "$networkKeymgmt" == "*" ] || [ -z "${networkKeymgmt// }" ] ; then 
			 export networkKeymgmt=WPA-PSK
		fi
		if [ "$networkPairwise" == "*" ] || [ -z "${networkPairwise// }" ] ; then 
			 export networkPairwise=TKIP
		fi
		if [ "$networkAuthalg" == "*" ] || [ -z "${networkAuthalg// }" ] ; then 
			 export networkAuthalg=OPEN
		fi
		# run wifi script
		cd "$ROOT_DIR/$SETUP_DIR"
		sudo ./install_wifi.sh "$networkId" "$networkPwd" $networkProto $networkKeymgmt $networkPairwise $networkAuthalg
		read -p "Press Enter... " pressanyk
	fi
	
	if [ "$userAction" == 9 ] ; then
		# run modprobe script
		echo "Running: modprobe w1-gpio"
		sudo modprobe w1-gpio
		echo "Running: modprobe w1-therm"
		sudo modprobe w1-therm
		echo "GPIO Done."
		read -p "Press Enter... " pressanyk
	fi
	
else
	echo "Please choose a valid option value"
	echo "Restarting script..."
	sleep 2
	cd "$ROOT_DIR/$SETUP_DIR"
	exit & exec "$ROOT_DIR/$SETUP_DIR/install.sh"
fi

cd "$ROOT_DIR/$SETUP_DIR"
exit & exec "$ROOT_DIR/$SETUP_DIR/install.sh"
