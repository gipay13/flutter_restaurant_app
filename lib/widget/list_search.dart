import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_restaurant_app/model/restaurant_model.dart';
import 'package:flutter_svg/svg.dart';

class ListSearch extends StatelessWidget {
  final Function onTap;
  final Restaurant restaurant;

  const ListSearch({Key key, this.onTap, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(7)), child: Image.network("https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}", width: 70,height: 150, fit: BoxFit.cover)),
      title:Text(restaurant.name ?? ""),
      subtitle: Row(
        children: [
          SvgPicture.asset("lib/assets/icon/location.svg", width: 15,),
          SizedBox(width: 3),
          Text(restaurant.city ?? "", style: Theme.of(context).textTheme.bodyText2,),
        ],
      ),
      trailing: RatingBarIndicator(
        rating: restaurant.rating ?? 0,
        itemSize: 20,
        itemBuilder: (_, __) {
          return SvgPicture.asset("lib/assets/icon/star.svg", color: Colors.amber,);
        },
      ),
      onTap: onTap,
    );
  }
}

