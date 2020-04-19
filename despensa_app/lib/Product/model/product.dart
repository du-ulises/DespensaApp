import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  String description;
  String urlImage;
  int likes;
  bool liked;
  double price;
  bool isBulk;
  String category;
  String store;

  Product(
      {Key key,
      @required this.name,
      @required this.description,
      @required this.urlImage,
      @required this.likes,
      @required this.liked,
      this.id,
      @required this.price,
      @required this.isBulk,
      @required this.category,
      @required this.store});
}
