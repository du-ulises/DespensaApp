import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/auth_page.dart';
import 'screens/calendar_page.dart';
import 'screens/main_page.dart';
import 'utils/class_builder.dart';

void main() {
  ClassBuilder.registerClasses();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Despensa App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Color(0xFFC42036),
        primaryColorDark: Color(0xFF2E3748)
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
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
          page: ClassBuilder.fromString('SettingsPage'),
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
          page: MainPage(),
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
          page: MainPage(),
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
          page: CalendarPage(),
        ),
      ],
    );
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                Navigator.of(context).push(CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return AuthPage();
                  },
                ));
              },
            ),
            //animationDuration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.centerRight,
                colors: [Color(0xFFC42036), Color(0xFF62101B), Color(0xFF62101B)],
                tileMode: TileMode.repeated,
              ),
            ),
          ),
        ],
      ),
    );
    /*
    return Scaffold(
      backgroundColor: Color(0xFFD02427),
      body: Center(

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFD02427),
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
    */
  }
}
