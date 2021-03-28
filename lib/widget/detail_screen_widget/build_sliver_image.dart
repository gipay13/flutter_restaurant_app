import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_detail_provider.dart';
import 'package:flutter_restaurant_app/model/restaurant_model.dart';
import 'package:provider/provider.dart';

import 'detail_image.dart';

class BuildSliverImage extends StatelessWidget {
  final double expandedHeight = 400;
  final double roundedContainerHeight = 50;
  final Restaurant restaurant;

  const BuildSliverImage({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RestaurantDetailProvider>(context);
    return SliverPersistentHeader(
      delegate: DetailImage(
          expandedHeight,
          roundedContainerHeight,
          "https://restaurant-api.dicoding.dev/images/medium/${state.restaurantDetailModel.restaurant.pictureId ?? ""}",
          state.restaurantDetailModel.restaurant.name ?? "",
          state.restaurantDetailModel.restaurant.city ?? "",
          state.restaurantDetailModel.restaurant.address ?? ""
      ),
    );
  }
}
