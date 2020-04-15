import 'package:flutter/material.dart';
import 'package:despensaapp/Client/model/client.dart';

class ClientInfo extends StatelessWidget {

  Client client;

  ClientInfo(this.client);

  @override
  Widget build(BuildContext context) {

    final clientPhoto = Container(
      width: 90.0,
      height: 90.0,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid
          ),
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              //image: AssetImage(user.photoURL)
              image: NetworkImage(client.photoURL)
          )
      ),
    );

    final clientInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        clientPhoto,
        Container(
            margin: EdgeInsets.only(
                top: 10.0
            ),
            child: Text(
                client.name,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: "Poppins-Regular",
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )
            )
        ),
        Text(
            client.email,
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
                fontFamily: 'Poppins-Regular'
            )
        ),
      ],
    );

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: clientInfo,
    );
  }
}