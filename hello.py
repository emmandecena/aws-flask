from flask import Flask, render_template

app = Flask(__name__,
            static_url_path='', 
            static_folder='templates')

@app.route("/")
@app.route("/index.html")
def home():
    return render_template("index.html")

