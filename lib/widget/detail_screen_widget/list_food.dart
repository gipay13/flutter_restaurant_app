import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_detail_provider.dart';
import 'package:provider/provider.dart';

class ListFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RestaurantDetailProvider>(context);

    return ExpansionTile(
      title: Text("Makanan", style: Theme.of(context).textTheme.headline6),
      children: [
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: state.restaurantDetailModel.restaurant.menus.foods.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Image.asset("lib/assets/image/food.png", fit: BoxFit.fitWidth, width: 70,),
                  Text(state.restaurantDetailModel.restaurant.menus.foods[index].name ?? "", style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
