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
  int _page = 2;
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
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.menu, color: Colors.black),
                              onPressed: widget.onMenuPressed,
                            ),
                          ),
                        ),
                        Text(
                          'Tu carrito',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Poppins-Medium",
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.search, color: Colors.black),
                              onPressed: () => {},
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
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Color(0xFFC42036).withOpacity(0.2),
                          BlendMode.dstATop),
                      child: Image.asset(
                        'assets/images/line-shopping-cart.png',
                        fit: BoxFit.cover,
                      ),
                    ),
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
                              icon: Icon(Icons.menu, color: Colors.black),
                              onPressed: widget.onMenuPressed,
                            ),
                          ),
                        ),
                        Text(
                          'Pedidos',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Poppins-Medium",
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.search, color: Colors.black),
                              onPressed: () => {},
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
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Color(0xFFC42036).withOpacity(0.2),
                          BlendMode.dstATop),
                      child: Image.asset(
                        'assets/images/line-truck.png',
                        fit: BoxFit.cover,
                      ),
                    ),
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
                              icon: Icon(Icons.menu, color: Colors.black),
                              onPressed: widget.onMenuPressed,
                            ),
                          ),
                        ),
                        Text(
                          'Despensa App.',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Poppins-Medium",
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.search, color: Colors.black),
                              onPressed: () => {},
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
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Color(0xFFC42036).withOpacity(0.2),
                          BlendMode.dstATop),
                      child: Image.asset(
                        'assets/images/online-store.png',
                        fit: BoxFit.cover,
                      ),
                    ),
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
                              icon: Icon(Icons.menu, color: Colors.black),
                              onPressed: widget.onMenuPressed,
                            ),
                          ),
                        ),
                        Text(
                          'Tus listas',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Poppins-Medium",
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.search, color: Colors.black),
                              onPressed: () => {},
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
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Color(0xFFC42036).withOpacity(0.2),
                          BlendMode.dstATop),
                      child: Image.asset(
                        'assets/images/line-list.png',
                        fit: BoxFit.cover,
                      ),
                    ),
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
                              icon: Icon(Icons.menu, color: Colors.black),
                              onPressed: widget.onMenuPressed,
                            ),
                          ),
                        ),
                        Text(
                          'Balance',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Poppins-Medium",
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.search, color: Colors.black),
                              onPressed: () => {},
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
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Color(0xFFC42036).withOpacity(0.2),
                          BlendMode.dstATop),
                      child: Image.asset(
                        'assets/images/line-credit.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  /*ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(Icons.home, color: Colors.black),
                        onPressed: () {
                          final CurvedNavigationBarState navBarState =
                              _bottomNavigationKey.currentState;
                          navBarState.setPage(2);
                        },
                      ),
                    ),
                  ),*/
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
        ));
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
