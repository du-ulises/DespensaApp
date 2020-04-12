import 'package:despensaapp/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

class StorePage extends KFDrawerContent {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
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
                        icon: Icon(Icons.menu, color: Colors.black),
                        onPressed: widget.onMenuPressed,
                      ),
                    ),
                  ),
                  Text(
                    'Tiendas',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Poppins-Medium",
                        color: Colors.black),
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
                  color: Colors.white,
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
                  Text('TIENDAS'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
