import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/model/services/api_services.dart';
import 'package:flutter_restaurant_app/screen/restaurant_list_screen.dart';
import 'package:flutter_restaurant_app/screen/restaurant_search_screen.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItemPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedItemPosition == 0
          ? ChangeNotifierProvider<RestaurantProvider>(create: (_) => RestaurantProvider(apiServices: ApiServices()), child: RestaurantListScreen(),)
          : _selectedItemPosition == 1
          ? ChangeNotifierProvider<RestaurantProvider>(create: (_) => RestaurantProvider(apiServices: ApiServices()), child: RestaurantSearchScreen(),)
          : Placeholder(),
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
          BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/icon/profile.svg", width: 25, color: palatte2)),
        ],
      ),
    );
  }
}


