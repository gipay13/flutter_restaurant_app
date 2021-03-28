import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/notification_provider.dart';
import 'package:flutter_restaurant_app/model/provider/preference_provider.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/widget/home_screen_widget/build_list.dart';
import 'package:flutter_restaurant_app/widget/home_screen_widget/build_search.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantListScreen> {
  TextEditingController searchController = new TextEditingController();
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eater", style: Theme.of(context).textTheme.headline5.copyWith(color: palatte2, fontWeight: FontWeight.bold),), centerTitle: true,
        actions: [
          Consumer<PreferencesProvider>(
            builder: (context, pref, child) {
              return pref.isDailyNewsActive
                  ? SvgPicture.asset("lib/assets/icon/ringing.svg", width: 30,)
                  : SvgPicture.asset("lib/assets/icon/bell.svg", width: 30);
            }
          ),
          Consumer<PreferencesProvider>(
            builder: (context, pref, child) {
              return Consumer<NotificationProvider>(
                builder: (context, notif, _) {
                  return Switch.adaptive(
                    activeColor: palatte2,
                    value: pref.isDailyNewsActive,
                    onChanged: (value) async {
                      notif.notificationRestaurant(value);
                      pref.enableDailyNews(value);
                    },
                  );
                },
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<RestaurantProvider>(
                  builder: (context, resto, _) {
                    return TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search_outlined),
                          hintText: "Search",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: buttonColor, width: 5.0)),
                          filled: true
                      ),
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                        resto.getRestaurantsSearch(query);
                      },
                    );
                  }
              ),
            ),
            query.trim().isNotEmpty ? BuildSearch() : BuildList()
          ],
        ),
      ),
    );
  }
}
