from flask import Flask
import os

app = Flask(__name__)

@app.route('/hello')
def hello_name():
   return f'Hello {os.environ["USER"]}'

if __name__ == '__main__':
   app.run(host="0.0.0.0")