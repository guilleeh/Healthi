import json
import requests

app_key = "f20172c14754bcaf49dc2748abd92cbe"
app_id = "5b7cb8f0"
api_url_base = "https://api.edamam.com/search"


def recipe_search():
    food_search = "chicken"
    api_url = "{}?q={}&app_id={}&app_key={}".format(api_url_base, food_search, app_id, app_key)
    print(api_url)

    response = requests.get(api_url)

    if response.status_code == 200:
        json_object = json.loads(response.content.decode('utf-8'))
        recipe_name = json_object["hits"][0]["recipe"]["label"]
        ingredients_list = json_object["hits"][0]["recipe"]["ingredientLines"]
        health_labels = json_object["hits"][0]["recipe"]["healthLabels"]
        source_url = json_object["hits"][0]["recipe"]["url"]

        print(recipe_name)
        print(ingredients_list)
        print(health_labels)
        print(source_url)

        recipe = {
            "recipe_name" : recipe_name,
            "ingredients" : ingredients_list,
            "health_labels" : health_labels,
            "source_url" : source_url
        }
        print("Successful call to API")

        return recipe
    else:

        return None


