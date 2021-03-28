import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/model/utils/navigation.dart';
import 'package:flutter_restaurant_app/model/utils/result_state.dart';
import 'package:flutter_restaurant_app/screen/detail_screen.dart';
import 'package:flutter_restaurant_app/widget/home_screen_widget/restaurant_list.dart';
import 'package:provider/provider.dart';

import '../blank_widget.dart';

class BuildSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    return RestaurantList(
                      restaurant: restaurantSearch,
                      onTap: () => Navigation.intentWithData(DetailScreen.routeName, restaurantSearch.id),
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
