from pymongo import MongoClient

client = MongoClient("mongodb://localhost")
db = client['test']


def insert_new():
    db.restaurants.insert_one({
        'address': {
            'street': 'Sportivnaya',
            'building': '126',
            'zipcode': '420500',
            'coord': [-73.9557413, 40.7720266]
        },
        'name': 'The Best Restaurant',
        'borough': 'Innopolis',
        'restaurant_id': '41712354',
        'cuisine': 'Serbian',
        'grades.0': [
            {
                'grade': 'A',
                'score': '11',
                'date': '2023-04-04'
            }
        ]
    })
    
    cur = db.restaurants.find({'address.street': 'Sportivnaya'})
    for c in cur:
        print(c)


insert_new()
