import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/notification_provider.dart';
import 'package:flutter_restaurant_app/model/provider/preference_provider.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/model/utils/navigation.dart';
import 'package:flutter_restaurant_app/model/utils/result_state.dart';
import 'package:flutter_restaurant_app/widget/blank_widget.dart';
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator(strokeWidth: 3,));
        } else if(state.state == ResultState.HasData) {
          return AnimationLimiter(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: state.restaurantList.restaurants.length,
              itemBuilder: (context, index) {
                var restaurantList = state.restaurantList.restaurants[index];
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
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: state.message,));
        } else {
          return Center(child: BlankWidget(icon: "lib/assets/icon/internet.svg", text: state.message,));
        }
      },
    );
  }
}
