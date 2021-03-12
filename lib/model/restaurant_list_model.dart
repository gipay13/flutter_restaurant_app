import 'dart:convert';

import 'package:flutter_restaurant_app/model/restaurant_model.dart';

RestaurantListModel restaurantListFromJson(String str) => RestaurantListModel.fromJson(json.decode(str));

String restaurantListToJson(RestaurantListModel data) => json.encode(data.toJson());

class RestaurantListModel {
  RestaurantListModel({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory RestaurantListModel.fromJson(Map<String, dynamic> json) => RestaurantListModel(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

