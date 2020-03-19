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


elasticsearch = None
def initialize_es(app):
    global elasticsearch
    elasticsearch = Elasticsearch([app.config['ELASTICSEARCH_URL']]) \
        if app.config['ELASTICSEARCH_URL'] else None


def get_elastic_conn():
    return elasticsearch

class SearchApi(Resource):

    @jwt_required
    def get(self, food_search):
        print(elasticsearch)
        if not elasticsearch:
            print("This")
            return []
        try:
            user_id = get_jwt_identity()
            user = User.objects.get(id=user_id)

            search_object = {
                "query": {
                    "bool": {
                        "must": {"match": {"label": food_search}},
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
            print()
            for key, value in res["hits"].items():
                if key == "hits":
                    for i in range(len(value)):
                        recipes_list.append((value[i]["_source"]))

            if user.objective == 'gain':
                recipes_list.sort(key=lambda x : x['calories'], reverse=True)
            elif user.objective == 'lose':
                recipes_list.sort(key=lambda x : x['calories'], reverse=False)

            return recipes_list

        except Exception as e:
            raise InternalServerError

