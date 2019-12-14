#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
export installdir="$DIR"
export setupdir="setup"

echo "Install Wifi dungle?"
read -p "[(Y)/n]: " yesornoWifi
if [ "$yesornoWifi" == "y" ] || [ "$yesornoWifi"  == "yes" ] || [ "$yesornoWifi" == "Y" ] || [ -z "${yesornoWifi// }" ] ; then
	if [ -z ${1+x} ] || [ -z ${2+x} ] ; then
		echo "WLAN Network info are missing. Please use './install_x.sh WLAN_SSID WLAN_PASSWORD WLAN_PROTOCOL WLAN_KEYMGMT WLAN_PAIRWISE WLAN_AUTHALG'"
		exit 0
	else
		echo "Starting Wifi dungle install..."
		echo "Wifi Network login : SSID '$1', PSK '$2', PROTOCOL '$3', KEYMGMT '$4', PAIRWISE '$5', AUTHALG '$6'"
		sleep 1
		
		# # Prepare, replace regex and copy wpa_supplicant.conf to /etc/wpa_supplicant/
		if grep "etwork={" "/etc/wpa_supplicant/wpa_supplicant.conf" ; then
			echo "wpa_supplicant already configured. Do you want to overrride?"
			read -p "[(Y)/n]: " yesornoOverride
			if [ "$yesornoOverride" == "y" ] || [ "$yesornoOverride"  == "yes" ] || [ "$yesornoOverride" == "Y" ] || [ -z "${yesornoOverride// }" ] ; then
				cp -f "$installdir/$setupdir/wpa_supplicant_tmpl.conf" "$installdir/$setupdir/wpa_supplicant.conf"
				sed -i "s/%%ssid/$1/g" "$installdir/$setupdir/wpa_supplicant.conf"
				sed -i "s/%%psk/$2/g" "$installdir/$setupdir/wpa_supplicant.conf"
				sed -i "s/%%proto/$3/g" "$installdir/$setupdir/wpa_supplicant.conf"
				sed -i "s/%%keymgmt/$4/g" "$installdir/$setupdir/wpa_supplicant.conf"
				sed -i "s/%%pairwise/$5/g" "$installdir/$setupdir/wpa_supplicant.conf"
				sed -i "s/%%authalg/$6/g" "$installdir/$setupdir/wpa_supplicant.conf"
				sudo cp -f "$installdir/$setupdir/wpa_supplicant.conf" "/etc/wpa_supplicant/wpa_supplicant.conf"
				echo "file wpa_supplicant.conf installed."
			else
				echo "No changes made to wpa_supplicant"
				sleep 1
			fi
		else
			cp -f "$installdir/$setupdir/wpa_supplicant_tmpl.conf" "$installdir/$setupdir/wpa_supplicant.conf"
			sed -i "s/%%ssid/$1/g" "$installdir/$setupdir/wpa_supplicant.conf"
			sed -i "s/%%psk/$2/g" "$installdir/$setupdir/wpa_supplicant.conf"
			sed -i "s/%%proto/$3/g" "$installdir/$setupdir/wpa_supplicant.conf"
			sed -i "s/%%keymgmt/$4/g" "$installdir/$setupdir/wpa_supplicant.conf"
			sed -i "s/%%pairwise/$5/g" "$installdir/$setupdir/wpa_supplicant.conf"
			sed -i "s/%%authalg/$6/g" "$installdir/$setupdir/wpa_supplicant.conf"
			sudo cp -f "$installdir/$setupdir/wpa_supplicant.conf" "/etc/wpa_supplicant/wpa_supplicant.conf"
			echo "file wpa_supplicant.conf installed."
		fi
		
		# # Add config lines to /etc/network/interfaces

		# allow-hotplug wlan0
		if grep "allow-hotplug wlan0" /etc/network/interfaces ; then
			echo "line 'allow-hotplug wlan0' found."
		else
			sudo echo "allow-hotplug wlan0" >> /etc/network/interfaces
			echo "line 'allow-hotplug wlan0' updated."
		fi
		# iface wlan0 inet manual
		if grep "iface wlan0 inet manual" /etc/network/interfaces ; then
			echo "line 'iface wlan0 inet manual' found."
		else
			sudo echo "iface wlan0 inet manual" >> /etc/network/interfaces
			echo "line 'iface wlan0 inet manual' updated."
		fi
		# wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
		if grep "wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" /etc/network/interfaces ; then
			echo "line 'wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf' found."
		else
			sudo echo "wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" >> /etc/network/interfaces
			echo "line 'wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf' updated."
		fi
		# iface wlan0 inet dhcp
		if grep "iface wlan0 inet dhcp" /etc/network/interfaces ; then
			echo "line 'iface wlan0 inet dhcp' found."
		else
			sudo echo "iface wlan0 inet dhcp" >> /etc/network/interfaces
			echo "line 'iface wlan0 inet dhcp' updated."
		fi
		
		# Reboot on prompt
		echo "Wifi dungle installed."
		sleep 1
		echo "Press Enter when ready to reboot..."
		read -s -n 1 key
		sudo reboot
		exit
	fi
fi
