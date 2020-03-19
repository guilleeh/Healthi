## resources/search.py

import datetime
from flask import request, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from database.models import User, Recipe
from flask_restful import Resource
from resources.apis.errors import SchemaValidationError, UnauthorizedError, InternalServerError
from pprint import pprint
import json
from elasticsearch import Elasticsearch



with open('./resources/data/user_collection.json', 'r') as fp:
    user_collection = json.load(fp)

# print(user_collection)
current_user = user_collection.get("SHPE-TEXAS")
health_labels = list()
diet_labels = list()
cautions = list()
objectives = list()

for key, value in current_user.items():
    if key == "dietLabels":
        diet_labels = value

    if key == "healthLabels":
        health_labels = value

    if key == "cautions":
        cautions = value

    if key == "objectives":
        objectives = value

print("DIET LABELS:: ", diet_labels)
print("HEALTH LABELS:: ", health_labels)
print("CAUTIONS:: ", cautions)
print("OBJECTIVES:: ", objectives)


elasticsearch = None
def initialize_es(app):
    global elasticsearch
    elasticsearch = Elasticsearch([app.config['ELASTICSEARCH_URL']]) \
        if app.config['ELASTICSEARCH_URL'] else None


class SearchApi(Resource):

    @jwt_required
    def get(self, food_search):
        if not elasticsearch:
            return []
        try:
            user_id = get_jwt_identity()
            user = User.objects.get(id=user_id)
            print(user.cautions)

            search_object = {
                "query": {
                    "bool": {
                        "must": {
                            "match": {"label": food_search}
                        },
                        "should": {
                            "terms": {"healthLabels": user.healthLabels},
                            "terms": {"dietLabels": user.dietLabels}
                        }
                        ,
                        "must_not": {
                            "terms": {
                                "cautions": user.cautions
                            }
                        }
                    }
                }
            }
            res = elasticsearch.search(index='recipe_index', body=json.dumps(search_object), request_timeout=60)

            recipes_list = list()
            for key, value in res["hits"].items():
                if key == "hits":
                    for i in range(len(value)):
                        recipes_list.append((value[i]["_source"]))

            return recipes_list

        except Exception as e:
            raise InternalServerError

