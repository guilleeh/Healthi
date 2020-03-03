## database/models.py

from .db import db
from flask_bcrypt import generate_password_hash, check_password_hash

class User(db.Document):
    name = db.StringField(required=True, unique=False)
    email = db.EmailField(required=True, unique=True)
    password = db.StringField(required=True, min_length=6)
    age = db.IntField(min_value=14, max_value=99, required=True)
    height = db.IntField(min_value=1, max_value=250, required=True) # centimeters
    weight = db.IntField(min_value=50, max_value=500, required=True) # lbs
    
    # TODO: 
    # objectives 
    # dietLabels
    # healthLabels
    # allergies (cautions)


    def hash_password(self):
        self.password = generate_password_hash(self.password).decode('utf8')

    def check_password(self, password):
        return check_password_hash(self.password, password)
