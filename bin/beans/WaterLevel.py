#!/usr/bin/python
# IoT Chip project version : 3.0

from rpisensors import proximity
import utils
from time import sleep
from smbus import SMBus

class WaterLevel:
    """Common base class for air humidity sensors"""

    name = "WaterLevel"
    sensor = None
    pin = None

    def __init__(self):
        confs = utils.getConfiguration(self.name)
        print("WaterLevel initialized - configuration found")
        sensor = proximity.VL6180X(0)



    def get(self):
        distance = sensor.read_distance()
        return distance
