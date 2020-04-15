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
            'Tienda',
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
    // TODO: implement build
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
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
                            'assets/images/logo.png',
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Despensa App',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Gilroy-ExtraBold",
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
            ),
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
                color: Colors.white,
              ),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).dispatch(
                  LoggedOut(),
                );
                //Navigator.of(context).pop();
              },
            ),
            //animationDuration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2E3748), Color(0xFF2E3748)],
                tileMode: TileMode.repeated,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
