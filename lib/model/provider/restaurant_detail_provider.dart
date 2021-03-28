import 'package:flutter/cupertino.dart';
import 'package:flutter_restaurant_app/model/restaurant_detail_model.dart';
import 'package:flutter_restaurant_app/model/services/api_services.dart';
import 'package:flutter_restaurant_app/model/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices apiServices;
  final String id;

  RestaurantDetailProvider({this.apiServices, this.id}){
    _fetchDetailRestaurant();
  }

  RestaurantDetailModel _restaurantDetailModel;
  String _message = "";
  ResultState _state;

  RestaurantDetailModel get restaurantDetailModel => _restaurantDetailModel;
  String get message => _message;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try{
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiServices.restaurantDetail(id);

      if(response.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "No Data Available";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetailModel = response;
      }
    } catch(e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}