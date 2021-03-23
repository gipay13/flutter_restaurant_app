import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_restaurant_app/model/restaurant_list_model.dart';
import 'package:flutter_restaurant_app/model/utils/navigation.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _notificationHelper;

  NotificationHelper.internal() {
    _notificationHelper = this;
  }

  factory NotificationHelper() => _notificationHelper ?? NotificationHelper.internal();

  Future<void> initializeNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitializationSetting = AndroidInitializationSettings("notif_icon");
    var initializationSetting = InitializationSettings(android: androidInitializationSetting);

    await flutterLocalNotificationsPlugin.initialize(initializationSetting, onSelectNotification: (String payload) async {
      if(payload != null) {
        print("Notification Payload : $payload");
      }
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RestaurantListModel restaurantList) async {
    var _channelId = "1";
    var _channelName = "Channel 01";
    var _channelDesc = "Eater Description Channel";

    var androidChannelSpecification = AndroidNotificationDetails(
      _channelId, _channelName, _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: "Ticker",
      playSound: true,
      styleInformation: DefaultStyleInformation(true, true)
    );

    var platformChannelSpecific = NotificationDetails(android: androidChannelSpecification);

    var notificationTitle = "<b>Restaurant Of The Day</b>";
    var notificationRestaurant = restaurantList.restaurants[0].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      notificationTitle,
      notificationRestaurant,
      platformChannelSpecific,
      payload: json.encode(restaurantList.toJson()),
    );
  }

  void configureSelectNotification(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = RestaurantListModel.fromJson(json.decode(payload));
      var restaurant = data.restaurants[0];
      Navigation.intentWithData(route, restaurant);
    });
  }
}