import json
import requests

# app_key = "f20172c14754bcaf49dc2748abd92cbe"
# app_id = "5b7cb8f0"
# api_url_base = "https://api.edamam.com/search"
search_recipe_config = json.loads(open('api_config.json').read())
app_key = search_recipe_config["search_recipe_api"]["app_key"]
app_id = search_recipe_config["search_recipe_api"]["app_id"]
api_url_base = search_recipe_config["search_recipe_api"]["api_url_base"]

food_search = ['chicken', 'pizza', "beef", "fish", "sandwich", "salmon", "shrimp", "sushi", "meat", "tacos", 'broccoli', "teriyaki", "potato", "tomato", "corn", "carrot", "apple", "eggs", "beans", "grapes", "watermelon", "oranges", "turkey", "omelet", "spinach", "hamburger", "coffee", "lettuce", "ramen", "pho", "kebab", "spaghetti", "rice", 'cookies', 'brownies', 'salad', 'chinese', 'pasta', 'soup', 'dumplings', 'cake', 'cupcakes', 'pork', 'bbq', 'chicken wings', 'sandwich', 'poke', 'fish', 'indian', 'curry', 'thai', 'meat pie', 'ice cream', 'oreo', 'chessecake', 'burritos', 'hamburger', 'mexican', 'american', 'italian', 'greek', 'meal prep','vegan', 'vegetarian', 'pescaterian', 'seafood', 'hot dog', 'artisan',  'gluten free', 'keto', 'diet', 'low carb', 'alcohol', 'sugar', 'no sugar','middle eastern', 'european', 'shrimp', 'brocoli', 'tomato', 'spinach', 'corn', 'beans', 'coffee', 'kebab', 'spaghetti', 'torta', 'omelet']
recipes_list = list()

with open('../../data/recipe_collection.json', 'r') as f:
    recipes = json.load(f)


def recipe_search(query: str):
    api_url = "{}?q={}&app_id={}&app_key={}&from=0&to=100".format(api_url_base, query, app_id, app_key)
    print(api_url)
    response = requests.get(api_url)

    if response.status_code == 200:
        json_object = json.loads(response.content.decode('utf-8'))

        for hit in json_object['hits']:
            recipe = hit['recipe']
            label = recipe.pop('uri')
            recipes[label] = recipe
            recipes_list.append(recipes)


for query in food_search:
    recipe_search(query)

with open('../../data/recipe_collection.json', 'w') as fp:
    json.dump(recipes, fp)
    # json.dump(recipes_list, fp)
