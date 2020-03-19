## resources/routes.py

from .auth import SignupApi, LoginApi
from .search import SearchApi

def initialize_routes(api):
    api.add_resource(SignupApi, '/api/auth/signup')
    api.add_resource(LoginApi, '/api/auth/login')

    api.add_resource(SearchApi, '/api/auth/search/<food_search>')