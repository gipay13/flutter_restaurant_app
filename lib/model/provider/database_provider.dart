import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/utils/result_state.dart';

import '../helper/database_helper.dart';
import '../restaurant_model.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({@required this.databaseHelper}) {
    _getBookmark();
  }

  ResultState _state;
  String _message;
  List<Restaurant> _bookmark = [];

  ResultState get state => _state;
  String get message => _message;
  List<Restaurant> get bookmark => _bookmark;

  void _getBookmark() async {
    _bookmark = await databaseHelper.getBookmark();

    if(_bookmark.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = "Start Save Restaurant";
    }
    notifyListeners();
  }

  void insertBookmark(Restaurant restaurant) async {
    try {
      await databaseHelper.insertBookmark(restaurant);
      _getBookmark();
    } catch(e) {
      _state = ResultState.Error;
      _message = "Error => $e";
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String id) async {
    final bookmarked = await databaseHelper.getBookmarkById(id);
    return bookmarked.isNotEmpty;
  }

  void deleteBookmark(String id) async {
    try {
      await databaseHelper.deleteBookmark(id);
      _getBookmark();
    } catch(e) {
      _state = ResultState.Error;
      _message = "Error => $e";
      notifyListeners();
    }
  }
}

