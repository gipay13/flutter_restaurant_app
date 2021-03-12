import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/restaurant_list_model.dart';
import 'package:flutter_restaurant_app/model/restaurant_model.dart';
import 'package:flutter_svg/svg.dart';

import '../assets/style/style.dart';

class RestaurantCard extends StatelessWidget {
  final Function onTap;
  final Restaurant restaurant;

  const RestaurantCard({Key key, this.onTap, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Ink.image(
            image: restaurant.id == null ? Container(width: 70, height: 150, child: Icon(Icons.error),) : NetworkImage("https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId ?? ''}",),
            fit: BoxFit.cover,
            height: double.infinity,
            child: InkWell(onTap: onTap),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(restaurant.name ?? "", style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, color: buttonColor),),
                Row(
                  children: [
                    SvgPicture.asset("lib/assets/icon/location.svg", width: 15,
                      color: Colors.white,),
                    SizedBox(width: 3),
                    Text(restaurant.city ?? "", style: TextStyle(color: Colors.white),),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}