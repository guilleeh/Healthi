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
    local_db_client = pymongo.MongoClient("mongodb://localhost:27017/")

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
    food_search = "spinach"
    api_url = "{}?q={}&app_id={}&app_key={}&from=0&to=100".format(api_url_base, food_search, app_id, app_key)
    print(api_url)

    response = requests.get(api_url)

    if response.status_code == 200:
        recipe_list = list()
        json_object = json.loads(response.content.decode('utf-8'))
        hits = json_object["hits"]

        for i in range(len(hits)):
            recipe_name = json_object["hits"][i]["recipe"]["label"]
            ingredients_list = json_object["hits"][i]["recipe"]["ingredientLines"]
            health_labels = json_object["hits"][i]["recipe"]["healthLabels"]
            source_url = json_object["hits"][i]["recipe"]["url"]
            calories = json_object["hits"][i]["recipe"]["calories"]
            total_time = json_object["hits"][i]["recipe"]["totalTime"]
            total_nutrients = json_object["hits"][i]["recipe"]["totalNutrients"]
            total_daily = json_object["hits"][i]["recipe"]["totalDaily"]
            digest = json_object["hits"][i]["recipe"]["digest"]

            print("Recipe Search API Call Request Info")
            print("-------------------------------------------------------------")
            print("recipe name:: ", recipe_name)
            print("ingredients list:: ", ingredients_list)
            print("health labels:: ", health_labels)
            print("source url:: ", source_url)
            print("calories:: ", calories)
            print("total_time:: ", total_time)
            print("total_nutrients:: ", total_nutrients)
            print("total_daily:: ", total_daily)
            print("digest:: ", digest)
            print("-------------------------------------------------------------")

            recipe = {
                "recipe_name": recipe_name,
                "ingredients": ingredients_list,
                "health_labels": health_labels,
                "source_url": source_url,
                "calories": calories,
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


recipe_collection = initalize_mongodb_client()
recipe_list = recipe_search()
insert_to_collection(recipe_list, recipe_collection)
view_content_collection(recipe_collection)

