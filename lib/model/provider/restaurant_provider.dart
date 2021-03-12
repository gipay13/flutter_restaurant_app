
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/restaurant_list_model.dart';
import 'package:flutter_restaurant_app/model/restaurant_search_model.dart';
import 'package:flutter_restaurant_app/model/services/api_services.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiServices apiServices;

  RestaurantProvider({this.apiServices}) {
    _fetchListRestaurant();
  }

  RestaurantListModel _restaurantListModel;
  RestaurantSearchModel _restaurantSearchModel;
  String _message = "";
  ResultState _state;

  RestaurantListModel get restaurantList => _restaurantListModel;
  RestaurantSearchModel get restaurantSearch => _restaurantSearchModel;
  String get message => _message;
  ResultState get state => _state;


  Future<dynamic> _fetchListRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiServices.restaurantList();

      if((response.restaurants.isEmpty)) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "No Data Available This Time";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantListModel = response;
      }

    } catch(e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiServices.restaurantSearch(query);

      if((response.founded == 0) || (response.restaurants.isEmpty)) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "No Data Available";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantSearchModel = response;
      }

    } catch(e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Error => $e";
    }
  }
}