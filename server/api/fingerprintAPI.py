from flask import Flask, redirect, url_for, request


app = Flask(__name__)
app.config["DEBUG"] = True


@app.route('/fingerprint/', methods=['GET'])
def home():
    return "<h1>Distant Reading Archive</h1><p>This site is a prototype API for distant reading of science fiction novels.</p>"

