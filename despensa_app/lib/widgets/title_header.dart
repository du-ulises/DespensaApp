import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {

  final String title;

  TitleHeader({Key key, @required this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
            title,
            style: TextStyle(
              color: Color(0xFF2E3748),
              fontSize: 24.0,
              fontFamily: "Gilroy-ExtraBold"
            ),
    );
  }

}