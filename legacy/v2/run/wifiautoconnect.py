#!/usr/bin/python
# IoT Chip project version : 2.0
# DEPRECATED

import glib
from pyudev import Context, Monitor
import os, time, ConfigParser
import subprocess

try:
    from pyudev.glib import MonitorObserver

    def device_event(observer, device):
        print '1- event {0} on device {1}'.format(device.action, device)
        if device.action == "add" :
            print('USB detected')
            time.sleep(5)

            for root, dirs, files in os.walk("/media"):
                for file in files:
                    if file.endswith("planthive_wifi.ini"):
                        print(os.path.join(root, file))
                        thefile = os.path.join(root, file)
            
            try:
                thefile
                if os.path.exists(thefile) and os.path.isfile(thefile):
                    print('Wi-Fi info file found')

                    config = ConfigParser.ConfigParser()
                    confPath = thefile
                    config.read(confPath)
                    if config.has_section('Credentials'):
                        dinfo = dict(config.items('Credentials'))
                    print(dinfo)
                    with open("/etc/wpa_supplicant/wpa_supplicant.conf", "a") as wpasfile:
                        wpasfile.write('network={\n')
                        wpasfile.write('\t ssid="'+dinfo["network_name"]+'"\n')
                        wpasfile.write('\t psk="'+dinfo["network_pass"]+'"\n')
                        wpasfile.write('\t key_mgmt=WPA-PSK\n')
                        wpasfile.write('}\n')
                    wpasfile.close()

                # subprocess.Popen(['sudo','umount',thefile])
            except NameError:
                print "WiFi info file not found"
except:
    from pyudev.glib import GUDevMonitorObserver as MonitorObserver

    def device_event(observer, action, device):
        print '2- event {0} on device {1}'.format(action, device)

context = Context()
monitor = Monitor.from_netlink(context)

monitor.filter_by(subsystem='usb')
observer = MonitorObserver(monitor)

observer.connect('device-event', device_event)
monitor.start()

glib.MainLoop().run()
