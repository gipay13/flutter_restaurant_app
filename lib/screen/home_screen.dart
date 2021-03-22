import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/helper/notification_helper.dart';
import 'package:flutter_restaurant_app/model/services/background_services.dart';
import 'package:flutter_restaurant_app/screen/bookmark_screen.dart';
import 'package:flutter_restaurant_app/screen/detail_screen.dart';
import 'package:flutter_restaurant_app/screen/restaurant_list_screen.dart';
import 'package:flutter_restaurant_app/screen/restaurant_search_screen.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'restaurant_list_screen.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundServices _backgroundServices = BackgroundServices();

  int _selectedItemPosition = 0;

  @override
  void initState() {
    super.initState();
    receivePort.listen((_) async => await _backgroundServices.someTask());
    _notificationHelper.configureSelectNotification(DetailScreen.routeNameList);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedItemPosition == 0
          ? RestaurantListScreen()
          : _selectedItemPosition == 1
          ? RestaurantSearchScreen()
          : BookmarkScreen(),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(35))),
        padding: EdgeInsets.zero,

        backgroundColor: primaryColor,

        snakeViewColor: palatte2,
        selectedItemColor: SnakeShape.circle == SnakeShape.indicator ? textColor : null,

        showUnselectedLabels: true,
        showSelectedLabels: true,

        currentIndex: _selectedItemPosition,
        onTap: (selected) => setState(() => _selectedItemPosition = selected),
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/icon/home.svg", width: 25, color: palatte2,)),
          BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/icon/search.svg", width: 25, color: palatte2)),
          BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/icon/bookmark.svg", width: 25, color: palatte2)),
        ],
      ),
    );
  }
}


