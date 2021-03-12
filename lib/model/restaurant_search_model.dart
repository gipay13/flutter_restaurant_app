import 'dart:convert';

import 'package:flutter_restaurant_app/model/restaurant_model.dart';

RestaurantSearchModel restaurantSearchFromJson(String str) => RestaurantSearchModel.fromJson(json.decode(str));

String restaurantSearchToJson(RestaurantSearchModel data) => json.encode(data.toJson());

class RestaurantSearchModel {
  RestaurantSearchModel({
    this.error,
    this.founded,
    this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory RestaurantSearchModel.fromJson(Map<String, dynamic> json) => RestaurantSearchModel(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}


