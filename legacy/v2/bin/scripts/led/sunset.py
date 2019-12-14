#!/usr/bin/python
import sys, getopt, time
import RPi.GPIO as GPIO

# this is a sample, do not use this method in test nor production
def sunset(self):
    GPIO.cleanup()

    speed = 1 # =1 default
    sleep = 0.1/speed
    pinRed = 0 
    pinBlue = 1
    fs = 3.14159 #500

    GPIO.setmode(GPIO.BCM)

    GPIO.setup(pinRed, GPIO.OUT)
    GPIO.setup(pinBlue, GPIO.OUT)

    pR = GPIO.PWM(pinRed, fs) 
    pB = GPIO.PWM(pinBlue, fs)
    pR.start(0)
    pB.start(0)

    bdc = 50
    rdc = 100

    pR.ChangeDutyCycle(rdc)
    pB.ChangeDutyCycle(bdc)

    while True:
        while rdc > 0:
            pR.ChangeDutyCycle(rdc)
            rdc = rdc - 1
            time.sleep(sleep*2)
            print(rdc)

        while bdc > 10:
            pB.ChangeDutyCycle(bdc)
            bdc = bdc - 0.5
            time.sleep(sleep*2)
            print(bdc)

        while bdc > 3:
            pB.ChangeDutyCycle(bdc)
            bdc = bdc - 0.1
            time.sleep(sleep*2)
            print(bdc)

        while bdc > 0.1:
            pB.ChangeDutyCycle(bdc)
            bdc = bdc - 0.05
            time.sleep(sleep*2)
            print(bdc)

        while bdc < 10:
            pB.ChangeDutyCycle(bdc)
            bdc = bdc + 0.1
            time.sleep(sleep)
            print(bdc)

        while bdc < 80:
            pB.ChangeDutyCycle(bdc)
            bdc = bdc + 0.5
            time.sleep(sleep*2)
            print(bdc)

        while rdc < 100:
            pR.ChangeDutyCycle(rdc)
            rdc = rdc + 1
            time.sleep(sleep*2)
            print(rdc)

        time.sleep(5)

