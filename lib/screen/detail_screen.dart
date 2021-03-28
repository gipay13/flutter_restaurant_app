
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_detail_provider.dart';
import 'package:flutter_restaurant_app/model/utils/result_state.dart';
import 'package:flutter_restaurant_app/widget/blank_widget.dart';
import 'package:flutter_restaurant_app/widget/detail_screen_widget/build_detail.dart';
import 'package:flutter_restaurant_app/widget/detail_screen_widget/build_sliver_image.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detail";

  final String id;
  final double expandedHeight = 400;
  final double roundedContainerHeight = 50;

  DetailScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(id: id),
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Stack(
          children: <Widget>[
            Consumer<RestaurantDetailProvider>(
              builder: (context, resto, _) {
                if (resto.state == ResultState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if(resto.state == ResultState.HasData) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      BuildSliverImage(),
                      SliverToBoxAdapter(
                        child: BuildDetail()
                      )
                    ],
                  );
                } else if(resto.state == ResultState.NoData) {
                  return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: resto.message,));
                } else {
                  return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: resto.message,));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
