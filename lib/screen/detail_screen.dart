import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/restaurant_list_model.dart';
import 'package:flutter_restaurant_app/model/restaurant_model.dart';
import 'package:flutter_restaurant_app/model/restaurant_search_model.dart';
import 'package:flutter_restaurant_app/widget/custom_iconbutton.dart';
import 'package:flutter_restaurant_app/widget/custom_sliver.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatelessWidget {
  static const routeNameList = "/detail_list";
  static const routeNameSearch = "/detail_search";

  final double expandedHeight = 400;
  final double roundedContainerHeight = 50;
  final Restaurant restaurant;

  const DetailScreen({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId ?? restaurant.pictureId}",
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                CustomIconButton(icon: "lib/assets/icon/love.svg", message: "You Love This Restaurant",),
                CustomIconButton(icon: "lib/assets/icon/share.svg", message: "You Share This Restaurant",),
                CustomIconButton(icon: "lib/assets/icon/save.svg", message: "You Save This Restaurant",)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("lib/assets/icon/star.svg", width: 30,),
                    SizedBox(width: 3,),
                    Text("${restaurant.rating ?? 0}", style: Theme.of(context).textTheme.headline5.copyWith(color: buttonColor, fontWeight: FontWeight.bold),)
                  ],
                ),
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
