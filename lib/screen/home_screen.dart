import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/local_restaurant_model.dart';
import 'package:flutter_restaurant_app/screen/detail_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              backgroundColor: buttonColor,
              expandedHeight: 120,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Makan Apa Hari Ini", style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),),
                centerTitle: true,
              ),
            ),
          ];
        },
        body: Container(child: _buildList(context),),
      ),
    );
  }
}

Widget _buildList(BuildContext context) {
  return FutureBuilder(
    future: fetchJson(context),
    builder: (context, snapshot) {
      if(snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Restaurant restaurant = snapshot.data[index];
            return _buildListItem(context, index, restaurant);
          }
        );
      }
      return Center(child: CircularProgressIndicator(strokeWidth: 3));
    },
  );
}

Widget _buildListItem(context, index, Restaurant restaurant) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
    leading: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(7)), child: Image.network(restaurant.pictureId, width: 70,height: 150, fit: BoxFit.cover)),
    title: Text(restaurant.name, style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, color: buttonColor),),
    subtitle: Column(
      children: [
        Row(
          children: [
            SvgPicture.asset("lib/assets/icon/location.svg", width: 15,),
            SizedBox(width: 3),
            Text(restaurant.city, style: Theme.of(context).textTheme.bodyText2,),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset("lib/assets/icon/star.svg", width: 15,),
            SizedBox(width: 3),
            Text("${restaurant.rating}", style: Theme.of(context).textTheme.bodyText2,),
          ],
        ),
      ],
    ),
    trailing: SvgPicture.asset("lib/assets/icon/forward.svg", width: 17,),
    onTap: () { Navigator.pushNamed(context, DetailScreen.routeName, arguments: restaurant); },
  );
}

Future<List<Restaurant>> fetchJson(BuildContext context) async {
  final jsonString = await DefaultAssetBundle.of(context).loadString("lib/model/local_restaurant.json");
  return restaurantFromJson(jsonString);
}




