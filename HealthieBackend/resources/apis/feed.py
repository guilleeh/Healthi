## resources/feed.py

import datetime
from flask import request
from flask_jwt_extended import jwt_required, get_jwt_identity
from database.models import User
from flask_restful import Resource
from resources.apis.errors import SchemaValidationError, UnauthorizedError, InternalServerError
from .search import elasticsearch
import numpy as np
import pickle


class FeedApi(Resource):

    @jwt_required
    def get(self):
        if not elasticsearch:
            return []
        try:
            body = request.get_json()
            user_id = get_jwt_identity()
            user = User.objects.get(id=user_id)
            user_rep = pickle.loads(user.representation)
            user_id = get_jwt_identity()
            user = User.objects.get(id=user_id)
            print(user.cautions)

            script_query = {
                "script_score": {
                    "query": {
                        "match_all": {
                            "should": {
                                "terms": { "healthLabels": user.healthLabels},
                                "terms": { "dietLabels": user.dietLabels}
                            },
                            "filter": {
                                "terms": { "cautions": user.cautions}
                            }
                        }
                    },
                    "script": {
                        "source": "cosineSimilarity(params.query_vector, doc['title_vector']) + 1.0",
                        "params": {"query_vector": user_rep}
                    }
                }
            }

            search_object = {
                "query": {
                    "bool": {
                        "should": {
                            "terms": { "healthLabels": user.healthLabels},
                            "terms": { "dietLabels": user.dietLabels}
                        },
                        "filter": {
                            "terms": { "cautions": user.cautions}
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

        except Exception as e:
            raise InternalServerError
