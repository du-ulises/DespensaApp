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

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

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
    final pages = [
      Stack(
        children: <Widget>[
          SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(_page.toString(), textScaleFactor: 10.0),
                  ),
                  RaisedButton(
                    child: Text('Go home'),
                    onPressed: () {
                      final CurvedNavigationBarState navBarState =
                          _bottomNavigationKey.currentState;
                      navBarState.setPage(2);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Stack(
        children: <Widget>[
          SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(_page.toString(), textScaleFactor: 10.0),
                  ),
                  RaisedButton(
                    child: Text('Go home'),
                    onPressed: () {
                      final CurvedNavigationBarState navBarState =
                          _bottomNavigationKey.currentState;
                      navBarState.setPage(2);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Stack(
        children: <Widget>[
          SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Color(0xFF2E3748),
                              ),
                              onPressed: widget.onMenuPressed,
                            ),
                          ),
                        ),
                        Text(
                          'Bienvenido',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Poppins-Medium",
                            color: Color(0xFF2E3748),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Color(0xFF2E3748),
                              ),
                              onPressed: widget.onMenuPressed,
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15.0,
                              offset: Offset(7.0, 7.0))
                        ]),
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Stack(
        children: <Widget>[
          SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(_page.toString(), textScaleFactor: 10.0),
                  ),
                  RaisedButton(
                    child: Text('Go home'),
                    onPressed: () {
                      final CurvedNavigationBarState navBarState =
                          _bottomNavigationKey.currentState;
                      navBarState.setPage(2);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Stack(
        children: <Widget>[
          SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(_page.toString(), textScaleFactor: 10.0),
                  ),
                  RaisedButton(
                    child: Text('Go home'),
                    onPressed: () {
                      final CurvedNavigationBarState navBarState =
                          _bottomNavigationKey.currentState;
                      navBarState.setPage(2);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFC42036),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Color(0xFFC42036),
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 50,
        items: <Widget>[
          Icon(Icons.add_shopping_cart, size: 20, color: Colors.black),
          Icon(Icons.settings_ethernet, size: 20, color: Colors.black),
          Icon(Icons.home, size: 20, color: Colors.black),
          Icon(Icons.list, size: 20, color: Colors.black),
          Icon(Icons.compare_arrows, size: 20, color: Colors.black),
        ],
        animationDuration: Duration(milliseconds: 200),
        index: 2,
        animationCurve: Curves.bounceInOut,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
      ),
        body: Container(
          color: Color(0xFFC42036),
          child: Center(
            child: Column(
              children: <Widget>[
                pages[_page],
              ],
            ),
          ),
        )
    );
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
