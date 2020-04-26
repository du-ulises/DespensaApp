import 'package:flutter/material.dart';

class Navbar extends AppBar {
	static Color darkColor =  Color(0xFF212121);
	static Color lightColor = Color(0xFFF4F8FF);
	Navbar({
		String appBarTitle,
		IconData leading,
		BuildContext context,
		bool isElegance
	}) : super(
		elevation: 0.0,
		backgroundColor: isElegance ? darkColor : Colors.white,
		centerTitle: true,
		title: Text(
			appBarTitle,
			style: TextStyle(
				color: isElegance ? lightColor : Colors.black,
				fontSize: 16.0,
				fontFamily: "Poppins-Medium",
			),
		),
		leading: IconButton(
			icon: Icon(
				leading,
				color: isElegance ? lightColor : Colors.black,
			),
			onPressed: () {
				Navigator.pop(context);
			},
		)
	);
}