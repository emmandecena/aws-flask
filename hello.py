from flask import Flask, render_template, session, request

app = Flask(__name__,
            static_url_path='', 
            static_folder='templates')

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/profile")
def profile():
    return render_template("pages-profile.html")


@app.route("/context")
def context():
    user_agent = request.headers.get("User-Agent")
    session_obj = session.values()
    return list(session_obj)

