from pymongo import MongoClient

client = MongoClient("mongodb://localhost") # will connect to localhost
db = client['test']


def ex4():
    restaurants = list(db.restaurants.find({'address.street': 'Prospect Park West'}))
    for restaurant in restaurants:
        a_grades = [grade for grade in restaurant["grades"] if grade["grade"] == "A"]
        if len(a_grades) > 1:
            db.restaurants.delete_one({'_id': restaurant['_id']})
        else:
            new_grade = {
                "date": '2023-04-04',
                "grade": "A",
                "score": 10
            }
            restaurant["grades"].append(new_grade)
            db.restaurants.replace_one({"_id": restaurant["_id"]}, restaurant)


ex4()
