import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/restaurant_model.dart';
import 'package:flutter_restaurant_app/widget/detail_screen_widget/custom_sliver.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detail";

  final double expandedHeight = 400;
  final double roundedContainerHeight = 50;
  final Restaurant restaurant;

  const DetailScreen({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              _buildSliverHead(),
              SliverToBoxAdapter(
                child: _buildDetail(context),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSliverHead() {
    return SliverPersistentHeader(
      delegate: DetailSliverDelegate(
          expandedHeight,
          roundedContainerHeight,
          "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId ?? ""}",
          restaurant.name ?? "",
          restaurant.city ?? ""
      ),
    );
  }

  Widget _buildDetail(BuildContext context) {
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
                    Text("${restaurant.rating ?? 0}", style: Theme.of(context).textTheme.headline5.copyWith(color: buttonColor, fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 10,),
                Text(restaurant.description ?? "", style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 10,),
                Text(restaurant.description ?? "", style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
