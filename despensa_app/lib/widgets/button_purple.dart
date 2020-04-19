import 'package:flutter/material.dart';

class ButtonPurple extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Icon iconText;
  final double widthButton;

  ButtonPurple(
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
                colors: [Color(0xFF4268D3), Color(0xFF584CD1)],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              buttonText,
              style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Poppins-Medium",
                  color: Colors.white),
            ),
            iconText
          ],
        ),
      ),
    );
  }
}
