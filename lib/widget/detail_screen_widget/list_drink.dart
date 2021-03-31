import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_detail_provider.dart';
import 'package:provider/provider.dart';

class ListDrink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RestaurantDetailProvider>(context);

    return ExpansionTile(
      title: Text("Minuman", style: Theme.of(context).textTheme.headline6),
      children: [
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: state.restaurantDetailModel.restaurant.menus.drinks.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Image.asset("lib/assets/image/drink.png", fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width/6,),
                  Text(state.restaurantDetailModel.restaurant.menus.drinks[index].name ?? "", style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
