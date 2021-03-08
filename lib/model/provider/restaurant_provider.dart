

import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant_app/model/restaurant_list_model.dart';
import 'package:flutter_restaurant_app/model/restaurant_search_model.dart';
import 'package:flutter_restaurant_app/model/services/api_services.dart';
import 'package:flutter_svg/avd.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices apiServices;

  RestaurantListProvider(this.apiServices) {
    _fetchRestaurant();
  }

  RestaurantList _restaurantList;
  String _message = '';
  ResultState _state;

  RestaurantList get result => _restaurantList;
  String get message => _message;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiServices.restaurantList();

      if(restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = restaurant;
      }

    } catch(e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}