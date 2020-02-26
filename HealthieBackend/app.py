## app.py

from flask import Flask
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager
from database.db import initialize_db
from flask_restful import Api
from resources.routes import initialize_routes
from resources.errors import errors
from apis import edamam
from database import db

app = Flask(__name__)
app.config.from_envvar('ENV_FILE_LOCATION')
app.config["MONGO_DBNAME"] = "recipe_database"
app.config["MONGO_URI"] = "mongodb://salvillalon45_notread:45%$HiFriend@ds263028.mlab.com:63028/recipe_database"

api = Api(app, errors=errors)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)

initialize_db(app)
initialize_routes(api)

recipe_collection = db.initalize_mongodb_client()
recipe_list = edamam.recipe_search()
# edmama.insert_to_collection(recipe_list, recipe_collection)
edamam.view_content_collection(recipe_collection)

if __name__ == '__main__':
    app.run(debug=True, load_dotenv=True)
