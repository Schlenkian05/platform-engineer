from flask import Flask, jsonify
import socket
import os

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "message": "Welcome to Tekton Python Demo",
        "hostname": socket.gethostname(),
        "environment": os.getenv("ENV", "Development")
    })

@app.route("/health")
def health():
    return jsonify({
        "status": "UP"
    })

@app.route("/version")
def version():
    return jsonify({
        "application": "tekton-python-demo",
        "version": "1.0.0"
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
