import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/widget/blank_widget.dart';
import 'package:flutter_restaurant_app/widget/restaurant_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      appBar: AppBar(title: Text("Eater", style: Theme.of(context).textTheme.headline6,), centerTitle: true,),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if(state.state == ResultState.HasData) {
          return AnimationLimiter(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return  AnimationConfiguration.staggeredGrid(
                    columnCount: 3,
                    position: index,
                    duration: const Duration(milliseconds: 200),
                    child: ScaleAnimation(
                      scale: 0.2,
                      child: SlideAnimation(
                        child: RestaurantCard(restaurant: restaurant, onTap: () { Navigator.pushNamed(context, DetailScreen.routeNameList, arguments: restaurant); }),
                      ),
                    )
                );
              },
              staggeredTileBuilder: (index) {
                return new StaggeredTile.count(1, index.isEven ? 2 : 3);
              },
            ),
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: "Unable Connect To Internet",));
        } else {
          return Center(child: Text(''));
        }
        return Center(child: CircularProgressIndicator(strokeWidth: 3));
      },
    );
  }
}
