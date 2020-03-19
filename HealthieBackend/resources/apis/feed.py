## resources/feed.py

import datetime
from flask import request
from flask_jwt_extended import jwt_required, get_jwt_identity
from database.models import User
from flask_restful import Resource
from resources.apis.errors import SchemaValidationError, UnauthorizedError, InternalServerError
from .search import get_elastic_conn
import numpy as np
import pickle
import json


class FeedApi(Resource):

    @jwt_required
    def get(self):
        if not get_elastic_conn():
            print('you are a failure')
            return []
        try:
            body = request.get_json()
            user_id = get_jwt_identity()
            user = User.objects.get(id=user_id)
            # user_rep = pickle.loads(user.representation)
            user_rep = user.representation
            user_id = get_jwt_identity()
            user = User.objects.get(id=user_id)
            print(user.cautions)
            # user_rep_vector = [0.1, 0.2, 0.3]

            script_query = {
                "query": {
                    "script_score": {
                        "query": {"match_all": {}},
                        "script": {
                            "source": "cosineSimilarity(params.query_vector, 'vec_repr) + 1.0",
                            # "source": "cosineSimilarity(params.query_vector, user_rep_vector) + 1.0",
                            "params": {"query_vector": user_rep}
                            # "params": {"query_vector": [0.1, 0.2, -0.3]}
                    }
                }
            }
            }
            res = get_elastic_conn().search(index='recipe_index', body=json.dumps(script_query), request_timeout=60)

            recipes_list = list()
            for key, value in res["hits"].items():
                if key == "hits":
                    for i in range(len(value)):
                        recipes_list.append((value[i]["_source"]))

            return recipes_list

        except Exception as e:
            print(e)
            raise InternalServerError
