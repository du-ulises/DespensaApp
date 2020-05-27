import 'package:despensaapp/Client/repository/firebase_auth_api.dart';
import 'package:despensaapp/Product/ui/widgets/card_image_favorites_list.dart';
import 'package:despensaapp/Product/ui/widgets/card_image_shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:despensaapp/Client/model/client.dart';
import 'package:despensaapp/Product/ui/widgets/card_image_list.dart';

class MyCart extends StatefulWidget {
  @override
  _HeaderAppBarState createState() => _HeaderAppBarState();
}

class _HeaderAppBarState extends State<MyCart> {
  final FirebaseAuthAPI _userRepository = FirebaseAuthAPI();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return StreamBuilder(
      stream: _userRepository.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
              ],
            );
          case ConnectionState.none:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
              ],
            );
          case ConnectionState.active:
            return showPlacesData(snapshot);
          case ConnectionState.done:
            return showPlacesData(snapshot);
          default:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
              ],
            );
        }
      },
    );
  }

  Widget showPlacesData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      return Stack(
        children: [Text("Usuario no logeado. Haz Login")],
      );
    } else {
      Client user = Client(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoUrl);
      return SafeArea(child: CardImageShoppingCart(user));
    }
  }
}
