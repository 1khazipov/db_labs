from pymongo import MongoClient

client = MongoClient("mongodb://localhost")
db = client['test']


def select_irish():
    cur = db.restaurants.find({'cuisine': 'Irish'})
    for c in cur:
        print(c)


def select_russian_irish():
    cur = db.restaurants.find({'$or': [{'cuisine': 'Irish'},
                                       {'cuisine': 'Russian'}]})
    for c in cur:
        print(c)


def select_address():
    cur = db.restaurants.find({'address.building': '284',
                               'address.street': 'Prospect Park West',
                               'address.zipcode': '11215'})
    for c in cur:
        print(c)


select_irish()
select_russian_irish()
select_address()
