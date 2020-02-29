### Install and start mongo using 
brew tap mongodb/brew
brew install mongodb-community@4.2
mongod --config /usr/local/etc/mongod.conf --fork

### Create Python Pipenv 
pip install --user pipenv
pipenv install (run inside project folder with Pipfile)


### Configuring JWT
export ENV_FILE_LOCATION=./.env

### Starting up backend
pipenv shell
python app.py


### Deploying to Heroku (from repo root)
git subtree push --prefix HealthieBackend/ heroku master 

### Deploying on GAE
gcloud app deploy && gcloud app logs tail -s default

### Recipe Search API
https://developer.edamam.com/edamam-docs-recipe-api

## Reverse engineered instacart API
https://github.com/kleinjm/instacart_api


## Other interesting links
https://github.com/openfoodfacts/openfoodfacts-ai
http://www.iaeng.org/publication/WCECS2018/WCECS2018_pp349-356.pdf
http://cs229.stanford.edu/proj2013/SawantPai-YelpFoodRecommendationSystem.pdf
