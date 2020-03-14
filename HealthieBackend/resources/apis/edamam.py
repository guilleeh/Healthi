import json
import requests

search_recipe_config = json.loads(open('api_config.json').read())
app_key = search_recipe_config["search_recipe_api"]["app_key"]
app_id = search_recipe_config["search_recipe_api"]["app_id"]
api_url_base = search_recipe_config["search_recipe_api"]["app_url_base"]


def recipe_search():
    food_search = "chicken"
    api_url = "{}?q={}&app_id={}&app_key={}".format(api_url_base, food_search, app_id, app_key)
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
                "total_daily": total_daily,
                "digest": digest
            }

            print("Successful call to API")

            recipe_list.append(recipe)

        return recipe_list

    else:
        return None



