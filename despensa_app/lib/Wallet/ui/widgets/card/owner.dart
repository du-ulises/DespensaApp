import 'package:flutter/material.dart';

class CardOwner extends StatelessWidget {
	CardOwner({this.name});

	final String name;

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.only(top: 5.0, left: 30.0),
			child: Text(
				name.toUpperCase(),
				style: TextStyle(
					color: Colors.white,
					fontSize: 18.0,
					fontFamily: "Poppins-Regular",
				)
			),
		);
	}
}