import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/restaurant_provider.dart';
import 'package:flutter_restaurant_app/widget/blank_widget.dart';
import 'package:flutter_restaurant_app/widget/list_search.dart';
import 'package:provider/provider.dart';

import '../model/restaurant_search_model.dart';
import '../model/services/api_services.dart';
import '../widget/list_search.dart';
import 'detail_screen.dart';

class RestaurantSearchScreen extends StatefulWidget {
  @override
  _RestaurantSearchScreenState createState() => _RestaurantSearchScreenState();

}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  TextEditingController searchController = new TextEditingController();
  String query = "";
  Future<RestaurantSearchModel> restaurantSearch;

  @override
  void setState(fn) {
    restaurantSearch = ApiServices().restaurantSearch(query);
    super.setState(fn);
  }

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
                        state.getRestaurantsSearch(query);
                      },
                    );
                  }
                ),
              ),
              query.trim().isNotEmpty ? _buildListConsumer() : BlankWidget(icon: "lib/assets/icon/search.svg", text: "Type Restaurant",)
            ],
          ),
        )
    );
  }

  Widget _buildListConsumer() {
    return Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if(state.state == ResultState.Loading) {
            return Expanded(child: Center(child: CircularProgressIndicator(strokeWidth: 3,)));
          } else if(state.state == ResultState.HasData) {
            return Expanded(
              child: ListView.builder(
                  itemCount: state.restaurantSearch.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurantSearch = state.restaurantSearch.restaurants[index];
                    return ListSearch(restaurant: restaurantSearch, onTap: () { Navigator.pushNamed(context, DetailScreen.routeNameSearch, arguments: restaurantSearch); },);
                  }
              ),
            );
          } else if(state.state == ResultState.NoData) {
            return BlankWidget(icon: "lib/assets/icon/error.svg", text: state.message,);
          } else {
            return BlankWidget(icon: "lib/assets/icon/error.svg", text: state.message,);
          }
        }
    );
  }
  Widget _buildListFutureBuilder() {
    return FutureBuilder(
        future: restaurantSearch,
        builder: (context, AsyncSnapshot<RestaurantSearchModel> snapshot) {
          var state = snapshot.connectionState;
          if(state == ConnectionState.waiting) {
            return Expanded(child: Center(child: CircularProgressIndicator(strokeWidth: 3,)));
          } else if (state == ConnectionState.done) {
            if(snapshot.hasData) {
              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurantSearch = snapshot.data.restaurants[index];
                      return ListSearch(restaurant: restaurantSearch, onTap: () { Navigator.pushNamed(context, DetailScreen.routeNameSearch, arguments: restaurantSearch); },);
                    }
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: snapshot.error.toString(),));
          }
          return Center(child: BlankWidget(icon: "lib/assets/icon/error.svg", text: "Unable Connect To Internet",));
        }
    );
  }
}



