import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarAndText extends StatefulWidget {
  AvatarAndText({Key key}) : super(key: key);

  _AvatarAndTextState createState() => _AvatarAndTextState();
}

class _AvatarAndTextState extends State<AvatarAndText>
    with TickerProviderStateMixin {
  AnimationController animationController;
  final imageOne = "assets/images/list.png";
  final textOne = "Su pedido está siendo preparado";
  final imageTwo = "assets/images/truck.png";
  final textTwo = "Su pedido está en camino";
  final imageThree = "assets/images/qr-code.png";
  final textThree = "Su pedido está listo para recoger";
  var actualImage = "assets/images/list.png";
  var actualText = "";

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
    animationController = AnimationController(
      duration: Duration(milliseconds: 10800),
      vsync: this,
    );
    animationController.forward();
    animationController.addListener(() {
      if (animationController.value < 0.450) {
        setState(() {
          actualImage = imageOne;
          actualText = textOne;
        });
      } else if (animationController.value >= 0.450 &&
          animationController.value < 0.900) {
        setState(() {
          actualImage = imageTwo;
          actualText = textTwo;
        });
      } else if (animationController.value >= 0.900 &&
          animationController.value <= 1.0) {
        setState(() {
          actualImage = imageThree;
          actualText = textThree;
        });
      } else {
        // do nothing
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AvatarAnimation(
      controller: animationController,
      image: actualImage,
      text: actualText,
      isElegance: _isElegance,
    );
  }
}

class AvatarAnimation extends StatelessWidget {
  AvatarAnimation(
      {Key key, this.controller, this.image, this.text, this.isElegance})
      : super(key: key);

  final AnimationController controller;
  final String image;
  final String text;
  final bool isElegance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Image.asset(image, width: 125),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
                color: isElegance ? Colors.black87 : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins-Medium"),
          ),
        ],
      ),
    );
  }
}
