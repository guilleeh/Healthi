## resources/tuning.py

import datetime
from flask import request
from flask_jwt_extended import jwt_required, get_jwt_identity
from database.models import User
from flask_restful import Resource
from resources.errors import SchemaValidationError, UnauthorizedError, InternalServerError

class FeedTunerApi(Resource):

    @jwt_required
    def get(self):
        try:
            body = request.get_json()
            user_id = get_jwt_identity()
            user = User.objects.get(id=user_id)


        except Exception as e:
            raise InternalServerError
