import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/widget/blank_widget.dart';
import 'package:flutter_restaurant_app/widget/restaurant_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Eater", style: Theme.of(context).textTheme.headline5.copyWith(color: palatte2, fontWeight: FontWeight.bold),), centerTitle: true,),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if(state.state == ResultState.HasData) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: state.restaurantList.restaurants.length,
            itemBuilder: (context, index) {
              var restaurantList = state.restaurantList.restaurants[index];
              return RestaurantCard(restaurant: restaurantList, onTap: () { Navigator.pushNamed(context, DetailScreen.routeNameList, arguments: restaurantList); },);
            }
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: state.message,));
        } else if(state.state == ResultState.Error) {
          return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: state.message,));
        } else {
          return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: "Unable Connect To Internet",));
        }
      },
    );
  }
}
