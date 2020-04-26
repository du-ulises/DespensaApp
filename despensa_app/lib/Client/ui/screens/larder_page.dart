import 'package:despensaapp/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LarderPage extends KFDrawerContent {
  @override
  _LarderPageState createState() => _LarderPageState();
}

class _LarderPageState extends State<LarderPage> {
  bool _isElegance = false;
  final Color darkColor =  Color(0xFF212121);
  final Color lightColor = Color(0xFFF4F8FF);

  Future<Null> getSharedPrefs() async {
    SharedPreferences theme = await SharedPreferences.getInstance();
    bool isElegance = (theme.getBool("Elegance") ?? false);
    setState(() {
      _isElegance = isElegance;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        icon: Icon(Icons.menu, color: _isElegance ? lightColor : Colors.black),
                        onPressed: widget.onMenuPressed,
                      ),
                    ),
                  ),
                  Text(
                    'Tu despensa',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Poppins-Medium",
                        color: _isElegance ? lightColor : Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  color: _isElegance ? darkColor : Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15.0,
                        offset: Offset(7.0, 7.0))
                  ]),
              padding: EdgeInsets.only(bottom: 5, top: 5),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('TU DESPENSA'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
