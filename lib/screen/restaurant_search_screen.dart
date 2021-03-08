import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/restaurant_search_model.dart';
import 'package:flutter_restaurant_app/model/services/api_services.dart';
import 'package:flutter_restaurant_app/widget/blank_widget.dart';
import 'package:flutter_restaurant_app/widget/list_search.dart';

import 'detail_screen.dart';

class RestaurantSearchScreen extends StatefulWidget {
  @override
  _RestaurantSearchScreenState createState() => _RestaurantSearchScreenState();

}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  TextEditingController searchController = new TextEditingController();
  String query = "";
  Future<RestaurantSearch> restaurantSearch;

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
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        hintText: "Search",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: buttonColor, width: 5.0)),
                        filled: true
                      ),
                      onChanged: (String value) {
                        setState(() {
                          query = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              query.isNotEmpty
                  ? FutureBuilder(
                      future: restaurantSearch,
                      builder: (context, AsyncSnapshot<RestaurantSearch> snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Expanded(child: Center(child: CircularProgressIndicator(strokeWidth: 3)));
                        } else if(snapshot.connectionState == ConnectionState.done) {
                          if(snapshot.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.restaurants.length,
                                  itemBuilder: (context, index) {
                                    var restaurant = snapshot.data.restaurants[index];
                                    return ListSearch(restaurantS: restaurant, onTap: () { Navigator.pushNamed(context, DetailScreen.routeNameSearch, arguments: restaurant); },);
                                  }
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }
                        return BlankWidget(icon: "lib/assets/icon/error.svg", text: "Unable Connect To Internet",);
                      }
                  )
                  : BlankWidget(icon: "lib/assets/icon/search.svg", text: "Type Restaurant",)
            ],
          ),
        )
    );
  }
}

