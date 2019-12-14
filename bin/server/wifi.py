#!/usr/bin/python

from flask import Flask, render_template, request
from subprocess import call
import time
import urllib
import urllib2
# creates a Flask application, named app
app = Flask(__name__)

# a route where we will display a welcome message via an HTML template


def __init__():
    print('init')
    call(["sudo","pyaccesspoint","start","-c"])




def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()

def shutdown():
    shutdown_server()
    return 'Server shutting down...'

def test_inet():
    loop_value = 1
    while (loop_value == 1):
        try:
            urllib.urlopen("https://www.google.com/")
        except urllib2.URLError, e:
            print "Network down."
            return 0
        else:
            print "Up and running."
            loop_value = 0
            return 1
    
@app.route("/")
def hello():
    return render_template('index.html')


@app.route('/', methods=['POST','GET'])
def wificonnect():
   
  print('Success1')
  if request.method == 'POST':
    ssid = request.form['ssid']
    try:
      password = request.form['password']
    except:
      password = None
    
    call(["sudo", "wpa_config", "add", "-f", str(ssid), str(password)])
    call(["sudo", "wpa_config", "make"])
    
    tmp = test_inet()
    
    if tmp ==1:
        
        time.sleep(3)
        call(["sudo","pyaccesspoint","stop"])
        call(["sudo","ifconfig","wlan0", "down"])
        call(["sudo","ifconfig","wlan0", "up"])
        shutdown()
        return 'PlantHive is now connnected to the Internet'
        
    else:
        print('Continue')
        return render_template('index.html')

    
if __name__ == "__main__":  
    #app.run(debug=True,host='0.0.0.0')
    __init__()
    app.run(host= '0.0.0.0')
