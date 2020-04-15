import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_event.dart';
import 'package:despensaapp/Client/ui/widgets/circle_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:despensaapp/Client/model/client.dart';
import 'package:despensaapp/Client/ui/widgets/profile_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class SettingsPage extends KFDrawerContent {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _localization = true;

  Future getClient() async {
    final String CLIENTS = "clients";
    final Firestore _db = Firestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final uid = await _auth.currentUser().then((FirebaseUser user) {
      return user.uid;
    });

    QuerySnapshot qn = await _db
        .collection(CLIENTS)
        .where("uid", isEqualTo: uid)
        .getDocuments();

    var clientInfo = [];
    clientInfo.add(qn.documents);

    await Jiffy.locale('es'); // e

    return clientInfo;
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Color(0xFFC42036);

    final styleItems = TextStyle(
      fontFamily: "Poppins-Regular",
      color: Colors.black,
    );
    final styleTitle = TextStyle(
        fontSize: 17,
        fontFamily: "Poppins-Regular",
        color: Colors.black,
        fontWeight: FontWeight.bold);

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
                    'Ajustes',
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
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: FutureBuilder(
                future: getClient(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color(0xFFC42036)),
                            backgroundColor: Colors.black)
                      ],
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Text("Error inesperado");
                    }
                    var client;
                    var dateFormat;
                    var phone;
                    DateTime birthday;
                    for (var snapshotClient in snapshot.data) {
                      if (snapshotClient[0].data["date"] == '') {
                        dateFormat = 'Ingresa tu fecha de cumpleaños';
                        birthday = DateTime.now();
                      } else {
                        dateFormat = Jiffy({
                          "month": int.parse(snapshotClient[0]
                              .data["date"]
                              .toString()
                              .substring(5, 7)),
                          "day": int.parse(snapshotClient[0]
                              .data["date"]
                              .toString()
                              .substring(8, 10)),
                        }).MMMMEEEEd;
                        birthday = DateTime(
                            int.parse(snapshotClient[0]
                                .data["date"]
                                .toString()
                                .substring(0, 4)),
                            int.parse(snapshotClient[0]
                                .data["date"]
                                .toString()
                                .substring(5, 7)),
                            int.parse(snapshotClient[0]
                                .data["date"]
                                .toString()
                                .substring(8, 10)));
                      }
                      if (snapshotClient[0].data["phone"] == '') {
                        phone = 'Ingresa tu número de teléfono';
                      } else {
                        phone = snapshotClient[0].data["phone"];
                      }
                      client = Client(
                          uid: snapshotClient[0].data["uid"],
                          name: snapshotClient[0].data["name"],
                          email: snapshotClient[0].data["email"],
                          photoURL: snapshotClient[0].data["photoURL"],
                          date: dateFormat,
                          birthday: birthday,
                          phone: phone);
                    }
                    return showProfileData(client);
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Permisos de la aplicación', style: styleTitle)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MergeSemantics(
                  child: ListTile(
                    title: Text('Notificaciones', style: styleItems),
                    subtitle: Text(
                        'Recibe notificaciones push sobre pagos, promociones, envíos, predicciones, etc.'),
                    trailing: CupertinoSwitch(
                      value: _notifications,
                      onChanged: (bool value) {
                        setState(() {
                          _notifications = value;
                        });
                      },
                      activeColor: activeColor,
                    ),
                    onTap: () {
                      setState(() {
                        _notifications = !_notifications;
                      });
                    },
                  ),
                ),
                MergeSemantics(
                  child: ListTile(
                    title: Text('Localización', style: styleItems),
                    subtitle: Text(
                        'Acceder a tu ubicación, tiendas virtuales cerca, recomendaciones, etc.'),
                    trailing: CupertinoSwitch(
                      value: _localization,
                      onChanged: (bool value) {
                        setState(() {
                          _localization = value;
                        });
                      },
                      activeColor: activeColor,
                    ),
                    onTap: () {
                      setState(() {
                        _localization = !_localization;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showProfileData(Client client) {
    return ProfileHeader(client);
  }

  void showAlertDelete(Client client) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text("Eliminar cuenta"),
            content: new Text("Está acción es irreversible, ¿desea continuar?"),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: new Text("Cancelar",
                      style: TextStyle(color: Colors.redAccent)),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  }),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                    deleteClient(client);
                  })
            ],
          );
        });
  }

  deleteClient(Client client) async {
    final String CLIENTS = "clients";
    final Firestore _db = Firestore.instance;
    await _db
        .collection(CLIENTS)
        .document(client.uid)
        .get()
        .then((DocumentSnapshot ds) {
      print(
          '+++++++++++++++++++++++++++++++++++++STATUS+++++++++++++++++++++++++++++++++');
      print(ds.data["status"]);
      if (ds.data["status"]) {
        _db
            .collection(CLIENTS)
            .document(client.uid)
            .updateData({'status': false});
      }
    });
    BlocProvider.of<AuthenticationBloc>(context).dispatch(
      LoggedOut(),
    );
  }
}
