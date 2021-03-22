import 'dart:isolate';

import 'dart:ui';

import 'package:flutter_restaurant_app/main.dart';
import 'package:flutter_restaurant_app/model/helper/notification_helper.dart';
import 'package:flutter_restaurant_app/model/services/api_services.dart';

final ReceivePort receivePort = ReceivePort();

class BackgroundServices {
  static BackgroundServices _backgroundServices;
  static String _isolateName = "Isolate";
  static SendPort _sendPort;

  BackgroundServices.createObject();

  factory BackgroundServices() {
    if(_backgroundServices == null) {
      _backgroundServices = BackgroundServices.createObject();
    }
    return _backgroundServices;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print("Notification Activated");
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiServices().restaurantList();
    await _notificationHelper.showNotification(flutterLocalNotificationsPlugin, result);

    _sendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _sendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}