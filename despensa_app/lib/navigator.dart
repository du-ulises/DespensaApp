import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Client/ui/screens/help_page.dart';
import 'Client/ui/screens/store_page.dart';
import 'Client/ui/screens/larder_page.dart';
import 'Client/ui/screens/settings_page.dart';
import 'Client/ui/screens/main_page.dart';
import 'utils/class_builder.dart';

import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Nav extends StatefulWidget {
  @override
  _Nav createState() => _Nav();
}

class _Nav extends State<Nav> {
  KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('MainPage'),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Dashboard',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Poppins-Regular",
                color: Colors.white,
              )),
          icon: Icon(Icons.dashboard, size: 20, color: Colors.white),
          page: MainPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Ajustes',
            style: TextStyle(
              fontSize: 15.0,
              fontFamily: "Poppins-Regular",
              color: Colors.white,
            ),
          ),
          icon: Icon(Icons.settings, size: 20, color: Colors.white),
          page: SettingsPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Tu despensa',
            style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Poppins-Regular",
                color: Colors.white),
          ),
          icon: Icon(Icons.restaurant_menu, size: 20, color: Colors.white),
          page: LarderPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Tiendas',
            style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Poppins-Regular",
                color: Colors.white),
          ),
          icon: Icon(Icons.store, size: 20, color: Colors.white),
          page: StorePage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Ayuda',
            style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Poppins-Regular",
                color: Colors.white),
          ),
          icon: Icon(Icons.help_outline, size: 20, color: Colors.white),
          page: HelpPage(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF2E3748),
                      Color(0xFF2E3748)
                      //Color(0xFFC42036),
                      //Color(0xFF62101B)
                      //Color(0xFFD02427)
                    ],
                    begin: FractionalOffset(0.2, 0.0),
                    end: FractionalOffset(1.0, 0.6),
                    stops: [0.0, 0.6],
                    tileMode: TileMode.clamp)),
            child: FittedBox(
              fit: BoxFit.none,
              alignment: Alignment(-1.5, -0.8),
              child: Container(
                width: screenHeight,
                height: screenHeight,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    borderRadius: BorderRadius.circular(screenHeight / 2)),
              ),
            ),
            /*Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold
        ),
      ),*/

            //alignment: Alignment(-0.9, -0.6),
          ),
          KFDrawer(
            //borderRadius: 0.0,
            shadowBorderRadius: 20.0,
            //menuPadding: EdgeInsets.all(0.0),
            //scrollable: true,
            controller: _drawerController,
            header: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 75.0),
                      margin: EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/circle-outline-red.png',
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Poppins-ExtraBold",
                          color: Color(0xFFC42036),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Despensa App",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Gilroy-ExtraBold",
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                )),
            footer: KFDrawerItem(
              text: Text(
                'Cerrar sesión',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Poppins-Medium",
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                Icons.input,
                color: Color(0xFFC42036),
              ),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).dispatch(
                  LoggedOut(),
                );
                //Navigator.of(context).pop();
              },
            ),
            //animationDuration: Duration(milliseconds: 200),
            /*decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2E3748), Color(0xFF2E3748)],
                tileMode: TileMode.repeated,
              ),
            ),*/
          ),
        ],
      ),
    );
  }
}
