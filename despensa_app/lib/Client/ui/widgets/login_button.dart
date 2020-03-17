import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  double width = 0.0;
  double heigth = 0.0;
  final VoidCallback _onPressed;

  Button({Key key, VoidCallback onPressed, @required this.text, this.heigth, this.width})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: 20.0,
        ),
        width: width,
        height: heigth,
        child: RaisedButton(
          splashColor: Colors.white70,
          onPressed: _onPressed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          highlightElevation: 0,
          color: Color(0xFFC42036),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                    fontFamily: "Gilroy-Light",
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color:  Colors.white
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 7.0)
              )
            ]
        )
    );
  }
}
