import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainPage extends KFDrawerContent {
  MainPage({
    Key key,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC42036),
      body: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            child: Material(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () => {widget.onMenuPressed()},
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Bienvenido',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: "Poppins-ExtraBold",
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                /*IconButton(
                  iconSize: 50,
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _animationController,
                  ),
                  onPressed: () => _handleOnPressed(),
                ),*/
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFC42036),
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 50,
        items: <Widget>[
          Icon(Icons.add_shopping_cart, size: 20, color: Colors.black),
          Icon(Icons.add, size: 20, color: Colors.black),
          Icon(Icons.home, size: 20, color: Colors.black),
          Icon(Icons.list, size: 20, color: Colors.black),
          Icon(Icons.compare_arrows, size: 20, color: Colors.black),
        ],
        animationDuration: Duration(
          milliseconds: 200
        ),
        index: 2,
        animationCurve: Curves.bounceInOut,
        onTap: (index){

        },
      ),
    );
    /*
    return SafeArea(
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
                        color: Colors.black,
                      ),
                      onPressed: widget.onMenuPressed,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Main'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  */
  }
  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }
}
