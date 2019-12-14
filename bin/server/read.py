#!/usr/bin/python

from flask import Flask, render_template, request
from subprocess import call

# creates a Flask application, named app
app = Flask(__name__)

# a route where we will display a welcome message via an HTML template



def __init__(self):
    print('init')


    
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
    exit()

#    f= open("data.txt","w+")
#    f.write("SSID = " + ssid)
#    f.write("Password = " + password)
#    f.close()
    # return render_template('index.html')

# run the application
if __name__ == "__main__":  
    #app.run(debug=True,host='0.0.0.0')
    app.run(host= '0.0.0.0')
