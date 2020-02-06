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


