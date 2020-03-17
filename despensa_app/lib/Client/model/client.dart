import 'package:flutter/material.dart';

class Client {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final String date;
  DateTime birthday;
  final String phone;

  Client({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoURL,
    this.date,
    this.birthday,
    this.phone
  });
}