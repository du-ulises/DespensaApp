import 'dart:async';

import 'package:despensaapp/Ticket/avatarAndText.dart';
import 'package:despensaapp/Ticket/progressBar.dart';
import 'package:despensaapp/Ticket/timer.dart';
import 'package:despensaapp/Ticket/util.dart';
import 'package:despensaapp/widgets/button_purple.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> with TickerProviderStateMixin {
  // final timerDuration = Duration(milliseconds: 2500);
  bool _isElegance = false;
  Future<Null> getSharedPrefs() async {
    SharedPreferences theme = await SharedPreferences.getInstance();
    bool isElegance = (theme.getBool("Elegance") ?? false);
    setState(() {
      _isElegance = isElegance;
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'Pedido#F62',
              style: TextStyle(
                  color: _isElegance
                      ? Color.fromRGBO(0, 0, 0, 0.2)
                      : Colors.white70,
                  fontSize: 12,
                  fontFamily: "Poppins-Regular"),
            ),
          ),
          Timer(),
          ProgressBar(),
          SizedBox(height: 10),
          AvatarAndText(),
          SizedBox(height: 10),
          Container(
            child: ButtonPurple(
                buttonText: "Ir al camión.",
                iconText: Icon(Icons.directions, color: Colors.white),
                widthButton: 300.0,
                onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
