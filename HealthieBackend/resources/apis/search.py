## resources/search.py

import datetime
from flask import request
from flask_jwt_extended import create_access_token
from database.models import User, Recipe
from flask_restful import Resource
from resources.apis.errors import SchemaValidationError, UnauthorizedError, InternalServerError
from flask import request
import logging
from elasticsearch import Elasticsearch
from pprint import pprint
import json

with open('./resources/data/user_collection.json', 'r') as fp:
    user_collection = json.load(fp)

# print(user_collection)
current_user = user_collection.get("SHPE-TEXAS")
print(type(current_user))


class SearchApi(Resource):

    def get(self, food_search):
        try:
            es_object = self.connect_elastic_search()
            search_object = {'query':
                                 {
                                     'match': {
                                          'label': food_search
                                       }
                                     # # "bool": {
                                     #     "filter": {
                                     #
                                     #     }
                                     # # }
                                  }
                             }
            res = self.search(es_object, 'recipe_index', json.dumps(search_object))

            recipes_list = list()
            for key, value in res["hits"].items():
                if key == "hits":
                    for i in range(len(value)):
                        recipes_list.append((value[i]["_source"]))

            return recipes_list

        except Exception as e:
            raise InternalServerError

    def connect_elastic_search(self):
        print("Inside connect_elastic_search()")

        _es = None
        _es = Elasticsearch([{'host': 'localhost', 'port': 9200}])

        if _es.ping():
            print('It has connected!')
        else:
            print('It could not connect!')

        return _es

    def create_index(self, es_object, index_name="recipe_index"):
        print("Inside create_index()")

        created = False

        try:
            if not es_object.indices.exists(index_name):
                # Ignore 400 means to ignore "Index Already Exist" error.
                es_object.indices.create(index=index_name, ignore=400)
                print('Index has been created')
                created = True

            else:
                print("Index has been created already")
                created = False

        except Exception as ex:
            print("Error creating the index")
            print(str(ex))

        finally:
            return created

    def store_record(self, elastic_object, index_name, record):
        print("Inside store_record()")

        try:
            outcome = elastic_object.index(index=index_name, doc_type='recipe_table', body=record, request_timeout=60)
            print("Record Stored!")
            return True

        except Exception as ex:
            print('Error in storing data')
            print(str(ex))
            return False

    def search(self, es_object, index_name, search):
        print("Inside search()")

        res = es_object.search(index=index_name, body=search, request_timeout=60)
        return res

    def open_json_file(self):
        print("Opening file")

        with open('../../data/recipe_collection.json', 'r') as f:
            result = json.load(f)
        print("File has has been loaded")

        return result
