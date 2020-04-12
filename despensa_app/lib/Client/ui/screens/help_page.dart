import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:liquid_swipe/Constants/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

class HelpPage extends KFDrawerContent {
  static final style = TextStyle(
    fontSize: 30,
    fontFamily: "Gilroy-ExtraBold",
    color: Color(0xFF1E2C40),
  );

  static final styleWhite = TextStyle(
    fontSize: 30,
    fontFamily: "Gilroy-ExtraBold",
    color: Color(0xFFF4F8FF),
  );
  static final mainColor = Color(0xFF1E2C40);
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  int page = 0;

  UpdateType updateType;

  final pages = [
    Container(
      color: Color(0xFFF4F8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/1.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 20, right: 15),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Diseño &",
                style: HelpPage.style,
              ),
              Text(
                "experencia",
                style: HelpPage.style,
              ),
              Text(
                "únicos",
                style: HelpPage.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.amberAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/1.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 10, right: 30),
                  child: Image.asset(
                    'assets/images/credito.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Pagos",
                style: HelpPage.style,
              ),
              Text(
                "fáciles y",
                style: HelpPage.style,
              ),
              Text(
                "seguros",
                style: HelpPage.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/1.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  width: 95,
                  margin: EdgeInsets.only(top: 10, right: 12),
                  child: Image.asset(
                    'assets/images/discount.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Ofertas,",
                style: HelpPage.styleWhite,
              ),
              Text(
                "descuentos &",
                style: HelpPage.styleWhite,
              ),
              Text(
                "promociones",
                style: HelpPage.styleWhite,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Color(0xFFF4F8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/1.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  width: 95,
                  margin: EdgeInsets.only(top: 15, right: 15),
                  child: Image.asset(
                    'assets/images/store.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Tiendas",
                style: HelpPage.style,
              ),
              Text(
                "virtuales",
                style: HelpPage.style,
              ),
              Text(
                "¡Quédate en casa!",
                style: HelpPage.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/1.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  width: 90,
                  margin: EdgeInsets.only(top: 20, right: 10),
                  child: Image.asset(
                    'assets/images/shopping-cart.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Búsqueda de",
                style: HelpPage.styleWhite,
              ),
              Text(
                "artículos &",
                style: HelpPage.styleWhite,
              ),
              Text(
                "carrito de compras",
                style: HelpPage.styleWhite,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Color(0xFFC42036),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/1.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  width: 90,
                  margin: EdgeInsets.only(top: 20, right: 8),
                  child: Image.asset(
                    'assets/images/qr-code.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Predicciones",
                style: HelpPage.styleWhite,
              ),
              Text(
                "semanales &",
                style: HelpPage.styleWhite,
              ),
              Text(
                "notificaciones",
                style: HelpPage.styleWhite,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.orangeAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/1.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  width: 95,
                  margin: EdgeInsets.only(top: 20, right: 5),
                  child: Image.asset(
                    'assets/images/package.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Envíos y",
                style: HelpPage.style,
              ),
              Text(
                "entregas,",
                style: HelpPage.style,
              ),
              Text(
                "rastrea tu paquete",
                style: HelpPage.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.pinkAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/1.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  width: 90,
                  margin: EdgeInsets.only(top: 20, right: 15),
                  child: Image.asset(
                    'assets/images/piggy-bank.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Ajusta tu",
                style: HelpPage.styleWhite,
              ),
              Text(
                "presupuesto y",
                style: HelpPage.styleWhite,
              ),
              Text(
                "optimiza tu gasto",
                style: HelpPage.styleWhite,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.greenAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/1.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 12, right: 12),
                  child: Image.asset(
                    'assets/images/groceries.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Llena la despensa",
                style: HelpPage.style,
              ),
              Text(
                "con los mejores",
                style: HelpPage.style,
              ),
              Text(
                "productos",
                style: HelpPage.style,
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: HelpPage.mainColor,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe(
            pages: pages,
            fullTransitionValue: 200,
            enableSlideIcon: true,
            enableLoop: true,
            positionSlideIcon: 0.5,
            onPageChangeCallback: pageChangeCallback,
            currentUpdateTypeCallback: updateTypeCallback,
            waveType: WaveType.liquidReveal,
            slideIconWidget: Icon(
              Icons.arrow_back_ios,
              color: HelpPage.mainColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(9, _buildDot),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        child: Material(
                          shadowColor: Colors.transparent,
                          color: Colors.transparent,
                          child: IconButton(
                            icon: Icon(
                              Icons.menu,
                              size: 35,
                              color: HelpPage.mainColor,
                            ),
                            onPressed: widget.onMenuPressed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  pageChangeCallback(int lpage) {
    print(lpage);
    setState(() {
      page = lpage;
    });
    //Navigator.of(context).pop();
  }

  updateTypeCallback(UpdateType updateType) {
    print(updateType);
  }
}
