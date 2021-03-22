import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final Future<SharedPreferences> sharedPreference;

  PreferenceHelper({@required this.sharedPreference});

  static const DAILY_NEWS = 'DAILY_NEWS';

  Future<bool> get isDailyNewsActive async {
    final prefs = await sharedPreference;
    return prefs.getBool(DAILY_NEWS) ?? false;
  }

  void setDailyNews(bool value) async {
    final prefs = await sharedPreference;
    prefs.setBool(DAILY_NEWS, value);
  }
}