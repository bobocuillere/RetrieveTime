import time
from flask import Flask

app = Flask(__name__)

@app.errorhandler(404)
def not_found(e):
    return {'error': 'Not Found'}, 404

@app.route('/api/time')
def get_current_time():
    return {'time': time.time()}

