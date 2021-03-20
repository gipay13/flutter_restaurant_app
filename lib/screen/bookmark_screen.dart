import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/provider/database_provider.dart';
import 'package:flutter_restaurant_app/model/utils/navigation.dart';
import 'package:flutter_restaurant_app/model/utils/result_state.dart';
import 'package:provider/provider.dart';

import '../assets/style/style.dart';
import '../widget/blank_widget.dart';
import '../widget/restaurant_card.dart';
import 'detail_screen.dart';

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Eater", style: Theme.of(context).textTheme.headline5.copyWith(color: palatte2, fontWeight: FontWeight.bold),), centerTitle: true,),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Consumer<DatabaseProvider>(
            builder: (context, state, child) {
              if(state.state == ResultState.Loading) {
                return Center(child: CircularProgressIndicator(strokeWidth: 3,));
              } else if(state.state == ResultState.HasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: state.bookmark.length,
                  itemBuilder: (context, index) {
                    var restaurantBookmark = state.bookmark[index];
                    return RestaurantCard(
                      restaurant: restaurantBookmark,
                      onTap: () => Navigation.intentWithData(DetailScreen.routeNameList, restaurantBookmark),
                    );
                  }
                );
              } else if(state.state == ResultState.NoData) {
                return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: state.message,));
              } else {
                return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: "Unable Connect To Internet",));
              }
            },
          ),
        ),
      ),
    );
  }
}
