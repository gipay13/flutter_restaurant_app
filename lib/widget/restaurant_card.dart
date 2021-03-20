import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/provider/database_provider.dart';
import 'package:flutter_restaurant_app/model/restaurant_list_model.dart';
import 'package:flutter_restaurant_app/model/restaurant_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../assets/style/style.dart';

class RestaurantCard extends StatelessWidget {
  final Function onTap;
  final Restaurant restaurant;

  const RestaurantCard({Key key, this.onTap, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, child) {
        return FutureBuilder<bool>(
          future: state.isBookmarked(restaurant.id),
          builder: (context,snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Card(
              child: Stack(
                children: [
                  Ink.image(
                    image: restaurant.id == null
                        ? Center(child: Container(width: 70, height: 150, child: SvgPicture.asset("lib/assets/icon/error.svg", color: Colors.black12,),))
                        : NetworkImage("https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId ?? ''}"),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    child: InkWell(onTap: onTap),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: isBookmarked
                          ? IconButton(
                            icon: Icon(Icons.bookmark),
                            onPressed: () => state.deleteBookmark(restaurant.id),
                          )
                          : IconButton(
                            icon: Icon(Icons.bookmark_border),
                            onPressed: () => state.insertBookmark(restaurant),
                          )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(restaurant.name ?? "", style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, color: secondaryColor),),
                        Row(
                          children: [
                            SvgPicture.asset("lib/assets/icon/location.svg", width: 15, color: Colors.white,),
                            SizedBox(width: 3),
                            Text(restaurant.city ?? "", style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        );
      },
    );
  }
}