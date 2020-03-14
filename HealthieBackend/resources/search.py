## resources/search.py

import datetime
from flask import request
from flask_jwt_extended import create_access_token
from database.models import User, Recipe
from flask_restful import Resource
from resources.errors import SchemaValidationError, UnauthorizedError, InternalServerError


class SearchApi(Resource):
    def get(self):
        try:
            print("Inside SearchAPI get request")

            # body = request.get_json()
            # recipe = Recipe(**body)
            # print(recipe.recipe_name)
            #
            #
            #     user.hash_password()
            #     user.save()
            #     id = user.id
            #
            #     return {'id': str(id)}, 200
            #
            # except FieldDoesNotExist:
            #     raise SchemaValidationError
            # except NotUniqueError:
            #     raise EmailAlreadyExistsError
            # except Exception as e:
            #     raise InternalServerError
        except Exception as e:
            raise InternalServerError
