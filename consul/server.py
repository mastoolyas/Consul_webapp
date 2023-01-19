from flask import Flask
import os 
import sys
import signal
PORT = 8000
MESSAGE = "Hello, world!\n"
API_USER = os.getenv('SECRETS_API_USER')


app = Flask(__name__)


@app.route("/")
def root():
    result = API_USER
    return result


if __name__ == "__main__":

    # print('My PID is:', os.getpid())
    

    app.run(debug=True, host="0.0.0.0", port=PORT)
