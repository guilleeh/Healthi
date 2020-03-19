import json
import requests
import pymongo
from flask_mongoengine import MongoEngine

app_key = "f20172c14754bcaf49dc2748abd92cbe"
app_id = "5b7cb8f0"
api_url_base = "https://api.edamam.com/search"

def initalize_mongodb_client():
    """
    This function initializes a Mongodb client
    """
    print("Creating client... ")
    # Assigns localhost:27017 to be the host for the Mongodb client
    # local_db_client = pymongo.MongoClient("mongodb://localhost:27017/")
    local_db_client = pymongo.MongoClient("mongodb+srv://todos:p9GtSWfloDl4XhDo@cluster0-me2k6.gcp.mongodb.net/test?retryWrites=true&w=majority")

    # creates search database
    print("Creating database")
    db = local_db_client.recipe_db

    # The database that will be used to search
    # It was made global because the search function is seperate see search_it()
    global recipe_collection
    recipe_collection = db.recipe_collection

    print("Creating collection::", recipe_collection)
    return recipe_collection


def recipe_search():
    food_search_list = ["pizza", "chicken", "beef", "fish", "salmon", "shrimp", "sushi", "meat", "tacos", "broccoli", "teriyaki", "potato", "tomato", "corn", "carrot", "apple", "eggs", "beans", "grapes", "watermelon", "oranges", "turkey", "omelet", "spinach", "hamburger", "coffee", "lettuce", "ramen", "pho", "kebab", "spaghetti", "rice"]
    # food_search = "rice"
    for food_search in food_search_list:
        api_url = "{}?q={}&app_id={}&app_key={}&from=0&to=100".format(api_url_base, food_search, app_id, app_key)
        print(api_url)

        response = requests.get(api_url)

        if response.status_code == 200:
            recipe_list = list()
            json_object = json.loads(response.content.decode('utf-8'))
            hits = json_object["hits"]

            for i in range(len(hits)):
                uri = json_object["hits"][i]["recipe"]["uri"]
                recipe_name = json_object["hits"][i]["recipe"]["label"]
                image = json_object["hits"][i]["recipe"]["image"]
                source = json_object["hits"][i]["recipe"]["source"]
                url = json_object["hits"][i]["recipe"]["url"]
                diet_labels = json_object["hits"][i]["recipe"]["dietLabels"]
                health_labels = json_object["hits"][i]["recipe"]["healthLabels"]
                cautions = json_object["hits"][i]["recipe"]["cautions"]
                ingredients_list = json_object["hits"][i]["recipe"]["ingredientLines"]
                calories = json_object["hits"][i]["recipe"]["calories"]
                total_weight = json_object["hits"][i]["recipe"]["totalWeight"]
                total_time = json_object["hits"][i]["recipe"]["totalTime"]
                total_nutrients = json_object["hits"][i]["recipe"]["totalNutrients"]
                total_daily = json_object["hits"][i]["recipe"]["totalDaily"]
                digest = json_object["hits"][i]["recipe"]["digest"]

                recipe = {
                    "uri": uri,
                    "recipe_name": recipe_name,
                    "image": image,
                    "source": source,
                    "url": url,
                    "diet_labels": diet_labels,
                    "health_labels": health_labels,
                    "cautions": cautions,
                    "ingredients": ingredients_list,
                    "calories": calories,
                    "total_weight": total_weight,
                    "total_time": total_time,
                    # "total_nutrients": total_nutrients,
                    "total_daily": total_daily,
                    "digest": digest
                }

                print("Successful call to API")

                recipe_list.append(recipe)

            return recipe_list

        else:
            return None


def insert_to_collection(recipe_list, recipe_collection):

    for recipe in recipe_list:
        recipe_collection.insert_one(recipe)

    print("done inserting")



recipe_collection = initalize_mongodb_client()
recipe_list = recipe_search()
insert_to_collection(recipe_list, recipe_collection)
# view_content_collection(recipe_collection)

