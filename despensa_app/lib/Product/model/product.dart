import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  String description;
  String urlImage;
  int likes;
  bool liked;
  bool added;
  double price;
  bool isBulk;
  String category;
  String store;
  int amount;

  Product({
    Key key,
    @required this.name,
    @required this.description,
    @required this.urlImage,
    @required this.likes,
    @required this.liked,
    @required this.added,
    this.id,
    @required this.price,
    @required this.isBulk,
    @required this.category,
    @required this.store,
    this.amount,
  });
}
