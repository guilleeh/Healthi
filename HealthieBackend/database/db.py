## database/db.py
import pymongo
from flask_mongoengine import MongoEngine

db = MongoEngine()


def initialize_db(app):
    db.init_app(app)


def initialize_mongodb_client():
    """
    This function initializes a Mongodb client
    """
    print("Creating client... ")
    # Assigns localhost:27017 to be the host for the Mongodb client
    # local_db_client = pymongo.MongoClient("mongodb://localhost:27017/")
    mlab_db_client = pymongo.MongoClient("mongodb://salvillalon45_notread:45%$HiFriend@ds263028.mlab.com:63028/recipe_database")

    # creates search database
    print("Creating database")
    db = mlab_db_client.recipe_db

    # The database that will be used to search
    # It was made global because the search function is seperate see search_it()
    global recipe_collection
    # recipe_collection = db.recipe_collection

    print("Creating collection::", recipe_collection)
    return recipe_collection


def insert_to_collection(recipe_list, recipe_collection):
    print("Inside insert_to_collection()")

    for recipe in recipe_list:
        print(recipe)
        recipe_collection.insert_one(recipe)


def view_content_collection(recipe_collection):
    print("Inside view_content_collection()")

    cursor = recipe_collection

    for document in cursor.find():
        print(document)
