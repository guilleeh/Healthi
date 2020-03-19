## main.py

from flask import Flask
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager
from database.db import initialize_db
from resources.apis.search import initialize_es
from flask_restful import Api
from resources.apis.routes import initialize_routes
from resources.apis.errors import errors


app = Flask(__name__)

# app.config.from_json('config.json')
app.config.from_json('local_config.json')


api = Api(app, errors=errors)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)

initialize_db(app)
initialize_routes(api)
initialize_es(app)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True, load_dotenv=True)
