import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_detail_provider.dart';
import 'package:flutter_restaurant_app/model/restaurant_model.dart';
import 'package:flutter_restaurant_app/widget/detail_screen_widget/list_drink.dart';
import 'package:flutter_restaurant_app/widget/detail_screen_widget/list_food.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BuildDetail extends StatelessWidget {
  final Restaurant restaurant;

  const BuildDetail({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RestaurantDetailProvider>(context);
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("lib/assets/icon/star.svg", color: Colors.amber, width: 25,),
                    SizedBox(width: 7,),
                    Text("${ state.restaurantDetailModel.restaurant.rating ?? 0}", style: Theme.of(context).textTheme.headline5.copyWith(color: buttonColor, fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 10,),
                Text(state.restaurantDetailModel.restaurant.description ?? "", style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 20,),
                ListFood(),
                SizedBox(height: 20,),
                ListDrink()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
