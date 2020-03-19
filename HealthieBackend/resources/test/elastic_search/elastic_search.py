import logging
from elasticsearch import Elasticsearch
from pprint import pprint
import json


def connect_elastic_search():
    print("Inside connect_elastic_search()")

    _es = None
    _es = Elasticsearch([{'host': 'localhost', 'port': 9200}])
    if _es.ping():
        print('It has connected!')
    else:
        print('It could not connect!')
    return _es


def create_index(es_object, index_name="recipe_index"):
    print("Inside create_index()")

    # index settings
    settings = {
        "settings": {
            "number_of_shards": 1,
            "number_of_replicas": 0
        },
        "mappings": {
            "recipe_table": {
                "dynamic": "strict",
                "properties": {
                    "label": {
                        "type": "text"
                    },
                    "image": {
                        "type": "text"
                    },
                    "source": {
                        "type": "text"
                    },
                    "url": {
                        "type": "text"
                    },
                    "shareAs": {
                        "type": "text"
                    },
                    "yield": {
                        "type": "integer"
                    },
                    "dietLabels": {
                        "type": "nested",
                        "properties": {
                            "type": "text"
                        }
                    },
                    "healthLabels": {
                        "type": "nested",
                        "properties": {
                            "type": "text"
                        }
                    },
                    "ingredientLines": {
                        "type": "nested",
                        "properties": {
                            "type": "text"
                        }
                    },
                    "ingredients": {
                        "type": "nested",
                        "properties": {
                            "step": {"type": "text", "type": "integer"}
                        }
                    },
                    "calories": {
                        "type": "integer"
                    },
                    "totalWeight": {
                        "type": "integer"
                    },
                    "totalTime": {
                        "type": "integer"
                    }
                }
            }
        }
    },

    try:
        if not es_object.indices.exists(index_name):
            # Ignore 400 means to ignore "Index Already Exist" error.
            es_object.indices.create(index=index_name, ignore=400)
            # es_object.indices.create(index=index_name, ignore=400, body=settings)
            print('Index has been created')

        else:
            print("Index has been created already")
            created = True

    except Exception as ex:
        print("Error creating the index")
        print(str(ex))

    finally:
        return True



def store_record(elastic_object, index_name, record):
    print("Inside store_record()")

    try:
        outcome = elastic_object.index(index=index_name, doc_type='recipe_table', body=record, request_timeout=60)
        # outcome = elastic_object.index(index_name, 'recipe_table', record, 60)
        print("Record Stored!")
        return True

    except Exception as ex:
        print('Error in storing data')
        print(str(ex))
        return False


def search(es_object, index_name, search):
    print("Inside search()")

    res = es_object.search(index=index_name, body=search, request_timeout=60)
    pprint(res)

    with open('../../data/output.json', 'w') as fp:
        json.dump(res, fp)


def open_json_file():
    print("Opening file")

    with open('../../data/recipe_collection.json', 'r') as f:
        result = json.load(f)
    print("File has has been loaded")

    return result


if __name__ == '__main__':
    print("Running Elastic Search ")
    print("---------------------------------------------")

    logging.basicConfig(level=logging.ERROR)
    es_object = connect_elastic_search()
    index_name = "recipe_index"
    result = open_json_file()

    if not es_object.indices.exists(index_name):
        print("Index does not exist so we will created it")
        # If index does not exist, then created it and stored records in the index
        for key, value in result.items():
            # print(key)
            # print(value)

            if es_object != None:
                index_check = create_index(es_object, index_name)
                print("Index Check:: ", index_check)
                if index_check:
                    print("index exists, so we going to store record into index")
                    store_record_check = store_record(es_object, index_name, value)
    else:
        # Search for food
        print("Index exists so we will search")
        search_object = {'query': {'match': {'label': 'pizza'}}}
        search(es_object, 'recipe_index', json.dumps(search_object))
