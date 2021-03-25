import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/notification_provider.dart';
import 'package:flutter_restaurant_app/model/provider/preference_provider.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/model/utils/navigation.dart';
import 'package:flutter_restaurant_app/model/utils/result_state.dart';
import 'package:flutter_restaurant_app/widget/blank_widget.dart';
import 'package:flutter_restaurant_app/widget/list_search.dart';
import 'package:flutter_restaurant_app/widget/restaurant_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';


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
            query.trim().isNotEmpty
                ? _buildSearchConsumer()
                : _buildList()
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, resto, _) {
        if (resto.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator(strokeWidth: 3,));
        } else if(resto.state == ResultState.HasData) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: resto.restaurantList.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurantList = resto.restaurantList.restaurants[index];
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: 2,
                    position: index,
                    duration: const Duration(milliseconds: 200),
                    child: ScaleAnimation(
                      scale: 0.2,
                      child: FadeInAnimation(
                        child: RestaurantCard(
                          restaurant: restaurantList,
                          onTap: () => Navigation.intentWithData(DetailScreen.routeNameList, restaurantList)
                        ),
                      ),
                    )
                  );
                }
              ),
            ),
          );
        } else if (resto.state == ResultState.NoData) {
          return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: resto.message,));
        } else {
          return Center(child: BlankWidget(icon: "lib/assets/icon/internet.svg", text: resto.message,));
        }
      },
    );
  }

  Widget _buildSearchConsumer() {
    return Consumer<RestaurantProvider>(
        builder: (context, resto, _) {
          if(resto.state == ResultState.Loading) {
            return Expanded(child: Center(child: CircularProgressIndicator(strokeWidth: 3,)));
          } else if(resto.state == ResultState.HasData) {
            return Expanded(
              child: ListView.builder(
                  itemCount: resto.restaurantSearch.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurantSearch = resto.restaurantSearch.restaurants[index];
                    return ListSearch(
                      restaurant: restaurantSearch,
                      onTap: () => Navigation.intentWithData(DetailScreen.routeNameSearch, restaurantSearch),
                    );
                  }
              ),
            );
          } else if(resto.state == ResultState.NoData) {
            return BlankWidget(icon: "lib/assets/icon/error.svg", text: resto.message,);
          } else {
            return BlankWidget(icon: "lib/assets/icon/error.svg", text: resto.message,);
          }
        }
    );
  }
}
