import 'package:flutter/material.dart';
import '../../../models/card_model.dart';
import './chip.dart';
import './last_number.dart';
import './logo.dart';
import './number.dart';
import './owner.dart';
import './valid_thru.dart';

class CardFront extends StatelessWidget {
	final CardResults cardModel;
	CardFront({this.cardModel});

	@override
	Widget build(BuildContext context) {
		double screenHeight = MediaQuery.of(context).size.height;
		double screenWidth = MediaQuery.of(context).size.width;
		return Stack(
			children: <Widget>[
				Container(
					width: screenWidth,
					height: screenHeight,
					decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(15.0),
							gradient: LinearGradient(
									colors: [
										cardModel.color,
										cardModel.color
									],
									begin: FractionalOffset(0.2, 0.0),
									end: FractionalOffset(1.0, 0.6),
									stops: [0.0, 0.6],
									tileMode: TileMode.clamp)),
					child: FittedBox(
						fit: BoxFit.none,
						alignment: Alignment(-1.5, -0.8),
						child: Container(
							width: screenHeight,
							height: screenHeight,
							decoration: BoxDecoration(
									color: Color.fromRGBO(0, 0, 0, 0.05),
									borderRadius: BorderRadius.circular(screenHeight / 2)),
						),
					),
				),
				RotatedBox(
					quarterTurns: 0,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: <Widget>[
							CardLogo(type: cardModel.type),
							CardChip(),
							CardNumber(number: cardModel.number),
							CardLastNumber(number: cardModel.number),
							CardValidThru(month: cardModel.month, year: cardModel.year),
							CardOwner(name: cardModel.name)
						],
					),
				)
			],
		);
	}
}