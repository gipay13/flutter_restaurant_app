import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/model/utils/navigation.dart';
import 'package:flutter_restaurant_app/model/utils/result_state.dart';
import 'package:flutter_restaurant_app/screen/detail_screen.dart';
import 'package:flutter_restaurant_app/widget/home_screen_widget/restaurant_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../blank_widget.dart';

class BuildList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, resto, _) {
        if (resto.state == ResultState.Loading) {
          return Expanded(child: Center(child: CircularProgressIndicator(strokeWidth: 3,)));
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
                                onTap: () => Navigation.intentWithData(DetailScreen.routeName, restaurantList.id)
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
          return Expanded(child: BlankWidget(icon: "lib/assets/icon/internet.svg", text: resto.message,));
        }
      },
    );
  }
}
