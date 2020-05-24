import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:despensaapp/Client/model/client.dart';

import 'package:jiffy/jiffy.dart';

class LarderPage extends KFDrawerContent {
  @override
  _LarderPageState createState() => _LarderPageState();
}

class _LarderPageState extends State<LarderPage> {
  bool _isElegance = false;
  final Color darkColor = Color(0xFF212121);
  final Color lightColor = Color(0xFFF4F8FF);
  String nameClient = "";
  String photoURL = "";

  Future<Null> getSharedPrefs() async {
    SharedPreferences theme = await SharedPreferences.getInstance();
    bool isElegance = (theme.getBool("Elegance") ?? false);
    setState(() {
      _isElegance = isElegance;
    });
  }

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

    await Jiffy.locale('es');
    for (var snapshotClient in clientInfo) {
      print("getClient");
      print(snapshotClient[0].data["name"]);
      setState(() {
        nameClient = snapshotClient[0].data["name"];
        photoURL = snapshotClient[0].data["photoURL"];
      });
    }
  }

  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: "Enviar mensaje"),
                style: TextStyle(fontFamily: "Poppins-Medium"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send,
                    color: _isElegance ? darkColor : Color(0xFFC42036)),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/despensa-app-a9c63-f07727095d53.json")
        .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.spanish);
    AIResponse response = await dialogflow.detectIntent(query);

    if (response.queryResult.parameters["number"] != null &&
        response.queryResult.intent.displayName == "Presupuesto") {
      print("RESPUESTA MENSAJE");
      print(response.queryResult.intent.displayName);
      print(response.queryResult.parameters["number"]);
    }
    for (var i = 0; i < response.getListMessage().length; i++) {
      ChatMessage message = ChatMessage(
          text: response.getListMessage()[i]["text"]["text"][0] ??
              TypeMessage(response.getListMessage()[0]).platform,
          name: "Bot",
          type: false,
          isElegance: _isElegance);
      setState(() {
        _messages.insert(0, message);
      });
    }
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
        text: text, name: nameClient, type: true, phothoUrl: photoURL);
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefs();
    getClient();
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
                        icon: Icon(Icons.menu,
                            color: _isElegance ? lightColor : Colors.black),
                        onPressed: () {
                          widget.onMenuPressed();
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
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
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: IconButton(
                          icon: Icon(Icons.clear,
                              color: _isElegance ? lightColor : Colors.black),
                          onPressed: () => {
                                setState(() {
                                  _messages.clear();
                                })
                              }),
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
                child: Column(children: <Widget>[
              _messages.length != 0
                  ? Flexible(
                      child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (_, int index) => _messages[index],
                      itemCount: _messages.length,
                    ))
                  : Flexible(
                      child: ListView(
                      padding: EdgeInsets.all(20.0),
                      reverse: false,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 6.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "Gilroy-ExtraBold",
                                    color: Color(0xFFC42036),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Mi nombre es Bot",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: "Gilroy-ExtraBold",
                                        color: Colors.black87,
                                      ),
                                    ),
                                    TextSpan(text: '.'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Center(
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Color(0xFFC42036), BlendMode.hue),
                              child: Image.asset(
                                "assets/images/happy-chatbot.gif",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "Gilroy-ExtraBold",
                                    color: Color(0xFFC42036),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Yo soy " + nameClient,
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: "Gilroy-ExtraBold",
                                        color: Colors.black87,
                                      ),
                                    ),
                                    TextSpan(text: '.'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0xFFC42036),
                        )
                      ],
                    )),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ]))
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {this.text, this.name, this.type, this.isElegance, this.phothoUrl});

  final String text;
  final String name;
  final bool type;
  final bool isElegance;
  final String phothoUrl;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          child: Image.asset("assets/images/person.png"),
          backgroundColor: isElegance ? Color(0xFF212121) : Color(0xFFC42036),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Poppins-Medium")),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child:
                  Text(text, style: TextStyle(fontFamily: "Poppins-Regular")),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(this.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Poppins-Medium")),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child:
                  Text(text, style: TextStyle(fontFamily: "Poppins-Regular")),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: phothoUrl != ""
            ? CircleAvatar(
                child: ClipOval(
                child: Image.network(
                  phothoUrl,
                ),
              ))
            : CircleAvatar(child: Text(this.name[0])),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
