## app.py

from flask import Flask
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager
from database.db import initialize_db
from flask_restful import Api
from resources.routes import initialize_routes
from dotenv import load_dotenv

load_dotenv(verbose=True)

app = Flask(__name__)
app.config.from_envvar('ENV_FILE_LOCATION')

api = Api(app)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)

app.config['MONGODB_SETTINGS'] = {
    'host': 'mongodb://localhost/HealthieDB'
}

initialize_db(app)
initialize_routes(api)

if __name__ == '__main__':
    app.run(debug=True)
