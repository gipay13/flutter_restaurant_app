import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_restaurant_app/model/restaurant_list_model.dart';
import 'package:flutter_restaurant_app/model/restaurant_search_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  final dio = Dio();

  Future<RestaurantList> restaurantList() async {
    final response = await http.get(_baseUrl + "list");

    if(response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Restaurant, Please Check Your Internet");
    }
  }

  Future<RestaurantSearch> restaurantSearch(String query) async {
    final response = await dio.get("https://restaurant-api.dicoding.dev/search", queryParameters: {"q": query});
    print(response.data);
    if(response.statusCode == 200) {
      return RestaurantSearch.fromJson(response.data);
    } else {
      throw Exception("Failed to Load Detail Restaurant, Please Check Your Internet");
    }
  }

}