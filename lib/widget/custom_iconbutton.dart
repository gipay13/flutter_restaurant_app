import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final String message;

  const CustomIconButton({Key key, this.icon, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => IconButton(icon: SvgPicture.asset(icon), onPressed: (){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
        })
    );
  }
}
