## resources/search.py

import datetime
from flask import request
from flask_jwt_extended import create_access_token
from database.models import User
from flask_restful import Resource
from resources.errors import SchemaValidationError, UnauthorizedError, InternalServerError

class SearchApi(Resource):
    def get(self):
        try:
            body = request.get_json()


        except Exception as e:
            raise InternalServerError
