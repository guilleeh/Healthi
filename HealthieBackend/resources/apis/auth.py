## resources/auth.py

import datetime
import json
from flask import request
from flask_jwt_extended import create_access_token
from database.models import User
from flask_restful import Resource
from mongoengine.errors import FieldDoesNotExist, NotUniqueError, DoesNotExist
from resources.apis.errors import SchemaValidationError, EmailAlreadyExistsError, UnauthorizedError, InternalServerError

class SignupApi(Resource):
    def post(self):
        try:
            user_dict = dict()
            body = request.get_json()

            for key, value in body.items():
                print(key)
                if key == "name":
                    user_dict[value] = body

            print("What is user_dict:: ", user_dict)

            with open('./resources/data/user_collection.json') as fp:
                user_collection = json.load(fp)

            user_collection.update(user_dict)

            with open('./resources/data/user_collection.json', 'w') as fp:
                json.dump(user_collection, fp, indent=4)

            user_dict = {}

            user = User(**body)
            user.hash_password()
            user.save()
            id = user.id

            return {'id': str(id)}, 200

        except FieldDoesNotExist:
            raise SchemaValidationError
        except NotUniqueError:
            raise EmailAlreadyExistsError
        except Exception as e:
            raise InternalServerError


class LoginApi(Resource):
    def post(self):
        try:
            body = request.get_json()
            user = User.objects.get(email=body.get('email'))
            authorized = user.check_password(body.get('password'))
            if not authorized:
                raise UnauthorizedError
 
            access_token = create_access_token(identity=str(user.id), expires_delta=False)
            
            return {'token': access_token}, 200
        
        except (UnauthorizedError, DoesNotExist):
            raise UnauthorizedError
        except Exception as e:
            raise InternalServerError
