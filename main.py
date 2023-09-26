from flask import Flask, jsonify, render_template
import time

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/execute/<callable_name>', methods=['POST'])
def execute_callable(callable_name):
    functions = {
        "InjectMessage": InjectMessage,
        "ProcessMessage": ProcessMessage,
        "StampMessagesToDB": StampMessagesToDB,
        "ValidateDB": ValidateDB
    }
    if callable_name in functions:
        log = functions[callable_name]()
        return jsonify({"status": "success", "log": log})
    else:
        return jsonify({"status": "error", "message": "Invalid callable name"})

def InjectMessage():
    time.sleep(1)
    return "InjectMessage executed"

def ProcessMessage():
    time.sleep(1)
    return "ProcessMessage executed"

def StampMessagesToDB():
    time.sleep(1)
    return "StampMessagesToDB executed"

def ValidateDB():
    time.sleep(1)
    return "ValidateDB executed"

if __name__ == '__main__':
    app.run(debug=True)
