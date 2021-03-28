import 'dart:convert';

import 'package:flutter_restaurant_app/model/restaurant_detail_model.dart';
import 'package:flutter_restaurant_app/model/restaurant_list_model.dart';
import 'package:flutter_restaurant_app/model/restaurant_search_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev";
  static final String _listEndpoint = "/list";
  static final String _searchEndpoint = "/search?q=";
  static final String _detailEndpoint = "/detail/";

  Future<RestaurantListModel> restaurantList() async {
    final response = await http.get(_baseUrl + _listEndpoint);

    if(response.statusCode == 200) {
      return RestaurantListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Restaurant, Please Check Your Internet");
    }
  }

  Future<RestaurantSearchModel> restaurantSearch(String query) async {
    final response = await http.get(_baseUrl + _searchEndpoint + query);
    if(response.statusCode == 200) {
      return RestaurantSearchModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Restaurant, Please Check Your Internet");
    }
  }

  Future<RestaurantDetailModel> restaurantDetail(String id) async {
    final response = await http.get(_baseUrl + _detailEndpoint + id);
    if(response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Detail Restaurant, Please Check Your Internet");
    }
  }

}