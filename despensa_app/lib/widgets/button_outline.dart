import 'package:flutter/material.dart';

class ButtonOutline extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Icon iconText;
  final double widthButton;

  ButtonOutline(
      {Key key,
      @required this.buttonText,
      @required this.onPressed,
      this.iconText,
      this.widthButton});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        height: 45.0,
        width: widthButton,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
                colors: [Color(0xFF212121), Color(0xFF212121)],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp),
          border: Border.all(
              color: Color(0xFFffffff),
              width: 1.0,
              style: BorderStyle.solid),
            boxShadow: <BoxShadow>[
              BoxShadow (
                  color:  Colors.black26,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 7.0)
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              buttonText,
              style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Poppins-Medium",
                  color: Color(0xFFffffff)),
            ),
            iconText
          ],
        ),
      ),
    );
  }
}
