import 'package:flutter/material.dart';
import 'package:despensaapp/Client/model/client.dart';
import 'package:despensaapp/Client/ui/widgets/client_info.dart';

class ProfileHeader extends StatelessWidget {
  Client client;

  ProfileHeader(this.client);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: ClientInfo(client),
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if(!snapshot.hasData || snapshot.hasError){
      print("No loggeado");
      return Container(
        margin: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0
        ),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("No se pudo cargar la información. Haz login")
          ],
        ),
      );
    }else{
      print("Loggeado");
      print(snapshot.data);
      client = Client(uid: snapshot.data.uid, name: snapshot.data.displayName, email: snapshot.data.email, photoURL: snapshot.data.photoUrl);
      final title = Text(
        'Profile',
        style: TextStyle(
            fontFamily: 'Nunito-Bold',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30.0
        ),
      );

      return Container(
        margin: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                title
              ],
            ),
            ClientInfo(client),
          ],
        ),
      );
    }
  }

}