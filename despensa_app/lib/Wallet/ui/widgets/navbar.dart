import 'package:flutter/material.dart';

class Navbar extends AppBar {
	Navbar({
		String appBarTitle,
		IconData leading,
		BuildContext context
	}) : super(
		elevation: 0.0,
		backgroundColor: Colors.white,
		centerTitle: true,
		title: Text(
			appBarTitle,
			style: TextStyle(
				color: Colors.black,
				fontSize: 16.0,
				fontFamily: "Poppins-Medium",
			),
		),
		leading: IconButton(
			icon: Icon(
				leading,
				color: Colors.black,
			),
			onPressed: () {
				Navigator.pop(context);
			},
		)
	);
}