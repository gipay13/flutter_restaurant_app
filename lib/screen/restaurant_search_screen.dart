import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/model/utils/navigation.dart';
import 'package:flutter_restaurant_app/model/utils/result_state.dart';
import 'package:flutter_restaurant_app/widget/blank_widget.dart';
import 'package:flutter_restaurant_app/widget/list_search.dart';
import 'package:provider/provider.dart';

import '../widget/list_search.dart';
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
        appBar: AppBar(title: Text("Eater", style: Theme.of(context).textTheme.headline5.copyWith(color: palatte2, fontWeight: FontWeight.bold),), centerTitle: true,),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<RestaurantProvider>(
                  builder: (context, resto, _) {
                    return TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        hintText: "Search",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: buttonColor, width: 5.0)),
                        filled: true
                      ),
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                        resto.getRestaurantsSearch(query);
                      },
                    );
                  }
                ),
              ),
              query.trim().isNotEmpty ? _buildSearchConsumer() : _buildListConsumer()
            ],
          ),
        )
    );
  }

  Widget _buildSearchConsumer() {
    return Consumer<RestaurantProvider>(
        builder: (context, resto, _) {
          if(resto.state == ResultState.Loading) {
            return Expanded(child: Center(child: CircularProgressIndicator(strokeWidth: 3,)));
          } else if(resto.state == ResultState.HasData) {
            return Expanded(
              child: ListView.builder(
                  itemCount: resto.restaurantSearch.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurantSearch = resto.restaurantSearch.restaurants[index];
                    return ListSearch(
                      restaurant: restaurantSearch,
                      onTap: () => Navigation.intentWithData(DetailScreen.routeNameSearch, restaurantSearch),
                    );
                  }
              ),
            );
          } else if(resto.state == ResultState.NoData) {
            return BlankWidget(icon: "lib/assets/icon/error.svg", text: resto.message,);
          } else {
            return BlankWidget(icon: "lib/assets/icon/error.svg", text: resto.message,);
          }
        }
    );
  }
  Widget _buildListConsumer() {
    return Consumer<RestaurantProvider>(
        builder: (context, resto, _) {
          if(resto.state == ResultState.Loading) {
            return Expanded(child: Center(child: CircularProgressIndicator(strokeWidth: 3,)));
          } else if(resto.state == ResultState.HasData) {
            return Expanded(
              child: ListView.builder(
                  itemCount: resto.restaurantList.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurantList = resto.restaurantList.restaurants[index];
                    return ListSearch(
                      restaurant: restaurantList,
                      onTap: () => Navigation.intentWithData(DetailScreen.routeNameSearch, restaurantList),
                    );
                  }
              ),
            );
          } else if(resto.state == ResultState.NoData) {
            return BlankWidget(icon: "lib/assets/icon/error.svg", text: resto.message,);
          } else {
            return BlankWidget(icon: "lib/assets/icon/error.svg", text: resto.message,);
          }
        }
    );
  }
}



