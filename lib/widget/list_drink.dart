import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/model/local_restaurant_model.dart';

class ListDrink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('lib/model/articles.json'),
          builder: (context, snapshot) {
            final List<Restaurant> restaurant = parseRestaurant(snapshot.data);
            if(snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                shrinkWrap: true,
                itemCount: restaurant.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("lib/assets/image/food.jpg"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(restaurant[index].menus.drinks[index].name),
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator(strokeWidth: 3));
          },
        )
    );
  }
}
