import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant_app/model/restaurant_list_model.dart';
import 'package:flutter_restaurant_app/model/restaurant_search_model.dart';
import 'package:flutter_restaurant_app/model/services/api_services.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiServices apiServices;


  RestaurantProvider({this.apiServices}) {
    getRestaurants();
  }

  RestaurantList _restaurantList;
  RestaurantSearch _restaurantSearch;
  String _message = "";
  ResultState _state;

  RestaurantList get restaurantList => _restaurantList;
  RestaurantSearch get restaurantSearch => _restaurantSearch;
  String get message => _message;
  ResultState get state => _state;

  void getRestaurants() {
    _restaurantData();
  }

  void getRestaurantsByQuery(String query) {
    _restaurantData(query: query);
  }

  void _restaurantData({String query = ""}) {
    _state = ResultState.Loading;
    notifyListeners();
    Future<dynamic> result;

    if(query.isEmpty) {
      result = _fetchRestaurant();
    } else {
      result = _searchRestaurant(query);
    }
    
    result.then((value){
      if(query.isEmpty) {
        _restaurantList = value;
      } else {
        _restaurantSearch = value;
      }
    });

  }

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiServices.restaurantList();

      if( (response.count == 0) || (response.restaurants.isEmpty)) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "No Data Available This Time";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = response;
      }

    } catch(e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _searchRestaurant(String query) async {
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
        return _restaurantSearch = response;
      }

    } catch(e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Error => $e";
    }
  }
}