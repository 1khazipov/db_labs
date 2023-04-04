from pymongo import MongoClient

client = MongoClient("mongodb://localhost")
db = client['test']


def delete_brooklyn():
    db.restaurants.delete_one({'borough': 'Brooklyn'})


def delete_thai():
    db.restaurants.delete_many({'cuisine': 'Thai'})


delete_brooklyn()
delete_thai()
