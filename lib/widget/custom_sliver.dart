import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_svg/svg.dart';

class DetailSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double roundeContainerHeight;
  final String pictureId;
  final String name;
  final String city;

  DetailSliverDelegate(this.expandedHeight, this.roundeContainerHeight, this.pictureId, this.name, this.city);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Stack(
        children: <Widget>[
          ShaderMask(
              shaderCallback: (rectangle) {
                return LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                ).createShader(Rect.fromLTRB(0, 0, rectangle.width, rectangle.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.network(pictureId, width: MediaQuery.of(context).size.width, height: expandedHeight, fit: BoxFit.cover)
          ),
          Positioned(
            top: expandedHeight - roundeContainerHeight - shrinkOffset,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: roundeContainerHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            top: expandedHeight - 120 - shrinkOffset,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: Theme.of(context).textTheme.headline4.copyWith(color: buttonColor, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    SvgPicture.asset("lib/assets/icon/location.svg", width: 17,),
                    SizedBox(width: 3),
                    Text(city, style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}