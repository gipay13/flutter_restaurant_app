import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/helper/preference_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferenceHelper preferenceHelper;

  PreferencesProvider({@required this.preferenceHelper}){
    _getDailyNewsPreferences();
  }

  bool _isDailyNewsActive = false;
  bool get isDailyNewsActive => _isDailyNewsActive;

  void _getDailyNewsPreferences() async {
    _isDailyNewsActive = await preferenceHelper.isDailyNewsActive;
    notifyListeners();
  }

  void enableDailyNews(bool value) {
    preferenceHelper.setDailyNews(value);
    _getDailyNewsPreferences();
  }

}