import 'package:flutter/material.dart';

class CardValidThru extends StatelessWidget {
	CardValidThru({this.month, this.year});

	final String month;
	final String year;

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.only(top: 5.0),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Column(
						children: <Widget>[
							Text(
								'VENCE',
								style: TextStyle(
									color: Colors.white,
									fontSize: 6.0,
									fontFamily: "Poppins-Medium",
								),
							),
							Text(
								'FIN DE',
								style: TextStyle(
									color: Colors.white,
									fontSize: 6.0,
									fontFamily: "Poppins-Medium",
								),
							)
						],
					),
					SizedBox(
						width: 5.0
					),
					Text(
						'$month/${year.substring(2)}',
						style: TextStyle(
							color: Colors.white,
							fontSize: 16.0,
							fontFamily: "Poppins-Medium",
						),
					)
				],
			),
		);
	}
}