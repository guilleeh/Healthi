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

            print("Recipe Search API Call Request Info")
            print("-------------------------------------------------------------")
            print("recipe name:: ", recipe_name)
            print("ingredients list:: ", ingredients_list)
            print("health labels:: ", health_labels)
            print("url:: ", url)
            print("calories:: ", calories)
            print("total_time:: ", total_time)
            print("total_nutrients:: ", total_nutrients)
            print("total_daily:: ", total_daily)
            print("digest:: ", digest)
            print("-------------------------------------------------------------")

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
                "total_nutrients": total_nutrients,
                "total_daily": total_daily,
                "digest": digest
            }

            print("Successful call to API")

            recipe_list.append(recipe)

        return recipe_list

    else:
        return None



