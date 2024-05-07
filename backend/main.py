from flask import Flask, request, Response
from flask_pymongo import PyMongo
from collections import OrderedDict
from flask_cors import CORS
import json

app = Flask(__name__)
CORS(app)

app.config["MONGO_URI"] = "mongodb://localhost:27017/users_db"
mongo = PyMongo(app)

def order_dish(dish):
    return OrderedDict([
        ('title', dish.get('title', '')),
        ('ingredients', dish.get('ingredients', '')),
        ('directions', dish.get('directions', '')),
        ('total_time', dish.get('total_time', '')),
        ('calories', str(dish.get('calories', ''))),
        ('carbohydrates_g', str(dish.get('carbohydrates_g', ''))),
        ('sugars_g', str(dish.get('sugars_g', ''))),
        ('fat_g', str(dish.get('fat_g', ''))),
        ('protein_g', str(dish.get('protein_g', ''))),
        ('image', dish.get('image', ''))  # Add image URL to the response
    ])

@app.route("/get_dish", methods=["GET"])
def get_dish():
    dish_name = request.args.get("dishName", "").lower() 
    if dish_name:
        dishes = mongo.db.recipes.find({"title": {"$regex": f".*{dish_name}.*", "$options": "i"}})
        if dishes:
            ordered_dishes = [order_dish(dish) for dish in dishes]
            json_output = json.dumps(ordered_dishes, indent=4)
            return Response(json_output, content_type='application/json') ,200
        else:
            return Response(json.dumps({"error": f"No recipes found containing '{dish_name}'"}), content_type='application/json')
    else:
        return Response(json.dumps({"error": "Please provide a dishname parameter"}), content_type='application/json')

if __name__ == "__main__":
    app.run(debug=True,port=3000)

