import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_restaurant_app/model/helper/time_helper.dart';
import 'package:flutter_restaurant_app/model/services/background_services.dart';

class NotificationProvider extends ChangeNotifier{
  bool _isSchedule = false;

  bool get isSchedule => _isSchedule;

  Future<bool> notificationRestaurant(bool value) async {
    _isSchedule = value;

    if(_isSchedule) {
      print("Scheduling Notification Activated");
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          Duration(hours: 24),
          1,
          BackgroundServices.callback,
          startAt: TimeHelper.format(),
          exact: true,
          wakeup: true
      );
    } else {
      print("Scheduling Dismised");
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}