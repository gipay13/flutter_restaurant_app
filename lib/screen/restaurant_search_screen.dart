import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/restaurant_search_model.dart';
import 'package:flutter_restaurant_app/model/services/api_services.dart';
import 'package:flutter_restaurant_app/widget/search_form.dart';
import 'package:flutter_svg/svg.dart';

class RestaurantSearchScreen extends StatefulWidget {
  @override
  _RestaurantSearchScreenState createState() => _RestaurantSearchScreenState();

}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  String query;
  Future<RestaurantSearch> restaurantSearch;

  @override
  void initState() {
    restaurantSearch = ApiServices().restaurantSearch(query);
    super.initState();
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
                child: SearchForm(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    }
                ),
              ),
              query != null
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
                                return ListTile(
                                  title:Text(restaurant.name),
                                );
                              }
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    return Text('');
                  }
              )
                  : Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("lib/assets/icon/search.svg", width: 170, color: Colors.black12,),
                    Text ("Type Restaurant", style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black12),),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}

