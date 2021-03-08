import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/screen/detail_screen.dart';
import 'package:flutter_restaurant_app/screen/home_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToEat',
        theme: ThemeData(
          primaryColor: buttonColor,
          accentColor: buttonColor,
          textTheme: customTheme,
        ),
        home: SplashScreenView(
          home: HomeScreen(),
          duration: 3000,
          imageSize: 100,
          imageSrc: "lib/assets/image/splash.png",
          backgroundColor: buttonColor,
        ),
        routes: {
          HomeScreen.routeName : (context) => HomeScreen(),
          DetailScreen.routeNameList : (context) => DetailScreen(restaurantL : ModalRoute.of(context).settings.arguments),
          DetailScreen.routeNameSearch : (context) => DetailScreen(restaurantS : ModalRoute.of(context).settings.arguments)
        }
    );
  }
}

