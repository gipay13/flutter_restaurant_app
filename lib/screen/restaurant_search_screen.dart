import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/widget/blank_widget.dart';
import 'package:flutter_restaurant_app/widget/list_search.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';

class RestaurantSearchScreen extends StatefulWidget {
  @override
  _RestaurantSearchScreenState createState() => _RestaurantSearchScreenState();

}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  TextEditingController searchController = new TextEditingController();
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Eater", style: Theme.of(context).textTheme.headline6,), centerTitle: true,),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<RestaurantProvider>(
                  builder: (context, state, _) {
                    return TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        hintText: "Search",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: buttonColor, width: 5.0)),
                        filled: true
                      ),
                      onChanged: (value) {
                        state.getRestaurantsByQuery(value);
                      },
                    );
                  }
                ),
              ),
              query.trim().isNotEmpty
                  ? Consumer<RestaurantProvider>(
                      builder: (context, state, _) {
                        state.getRestaurantsByQuery(query);

                        if(state.state == ResultState.Loading) {
                          return Expanded(child: Center(child: CircularProgressIndicator(strokeWidth: 3)));
                        } else if(state.state == ResultState.HasData) {
                            return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.restaurantSearch.restaurants.length,
                                  itemBuilder: (context, index) {
                                    var restaurant = state.restaurantSearch.restaurants[index];
                                    print(restaurant.name);
                                    return ListSearch(restaurantS: restaurant, onTap: () { Navigator.pushNamed(context, DetailScreen.routeNameSearch, arguments: restaurant); },);
                                  }
                              );
                        } else if(state.state == ResultState.NoData) {
                          return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: state.message,));
                        } else if (state.state == ResultState.Error) {
                          return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: state.message));
                        } else {
                          return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: "Unable Connect To Internet",));
                        }
                      }
                  )
                  : BlankWidget(icon: "lib/assets/icon/search.svg", text: "Type Restaurant",)
            ],
          ),
        )
    );
  }
}

