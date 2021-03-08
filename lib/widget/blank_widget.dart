import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BlankWidget extends StatelessWidget {
  final String icon;
  final String text;

  const BlankWidget({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, width: 170, color: Colors.black12,),
          Text (text, style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black12),),
        ],
      ),
    );
  }
}
