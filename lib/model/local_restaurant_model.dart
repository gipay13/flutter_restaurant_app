// To parse this JSON data, do
// https://app.quicktype.io/
//     final restaurant = restaurantFromJson(jsonString);

import 'dart:convert';

List<Restaurant> restaurantFromJson(String str) => List<Restaurant>.from(json.decode(str).map((x) => Restaurant.fromJson(x)));

String restaurantToJson(List<Restaurant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toDouble(),
    menus: Menus.fromJson(json["menus"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
    "menus": menus.toJson(),
  };
}

List<Restaurant> parseRestaurant(String json) {
  if (json == null) {
    return [];
  }


  final List parsed = jsonDecode(json);
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}

class Menus {
  Menus({this.foods, this.drinks,});

  List<Drink> foods;
  List<Drink> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
    drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}

class Drink {
  Drink({this.name,});

  String name;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(name: json["name"],);

  Map<String, dynamic> toJson() => {"name": name,};
}
