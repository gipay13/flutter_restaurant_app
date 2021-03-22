import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/helper/notification_helper.dart';
import 'package:flutter_restaurant_app/model/provider/database_provider.dart';
import 'package:flutter_restaurant_app/model/services/background_services.dart';
import 'package:flutter_restaurant_app/model/utils/navigation.dart';
import 'package:flutter_restaurant_app/screen/detail_screen.dart';
import 'package:flutter_restaurant_app/screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'model/helper/database_helper.dart';
import 'model/provider/restaurant_provider.dart';
import 'model/services/api_services.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundServices _backgroundServices = BackgroundServices();

  _backgroundServices.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await _notificationHelper.initializeNotification(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider(apiServices: ApiServices())),
        ChangeNotifierProvider(create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Eater',
          theme: ThemeData(
            primaryColor: primaryColor,
            accentColor: secondaryColor,
            textTheme: customTheme,
          ),
          home: SplashScreenView(
            home: HomeScreen(),
            duration: 3000,
            imageSize: 100,
            imageSrc: "lib/assets/image/splash.png",
            text: "Eater",
            textStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          navigatorKey: navigatorKey,
          routes: {
            HomeScreen.routeName : (context) => HomeScreen(),
            DetailScreen.routeNameList : (context) => DetailScreen(restaurant : ModalRoute.of(context).settings.arguments),
            DetailScreen.routeNameSearch : (context) => DetailScreen(restaurant : ModalRoute.of(context).settings.arguments)
          }
      ),
    );
  }
}

