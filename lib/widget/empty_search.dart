import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("lib/assets/icon/search.svg", width: 170, color: Colors.black12,),
          Text ("Type Restaurant", style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black12),),
        ],
      ),
    );
  }
}
