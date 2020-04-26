import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets//navbar.dart';
import './widgets/buttons/button.dart';
import './card_create.dart';

class CardType extends StatefulWidget {
  @override
  _CardTypeState createState() => _CardTypeState();
}

class _CardTypeState extends State<CardType> {
	bool _isElegance = false;
	final Color darkColor =  Color(0xFF212121);
	final Color lightColor = Color(0xFFF4F8FF);

	Future<Null> getSharedPrefs() async {
		SharedPreferences theme = await SharedPreferences.getInstance();
		bool isElegance = (theme.getBool("Elegance") ?? false);
		setState(() {
			_isElegance = isElegance;
		});
	}

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
		getSharedPrefs();
	}

	@override
	Widget build(BuildContext context) {

		final _buildTextInfo = Padding(
			padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
			child: Text.rich(
				TextSpan(
					text: 'Ahora puede agregar tarjetas de regalo con un saldo específico en la billetera. Cuando los saldos lleguen a \$0.00, desaparecerán automáticamente. ¿Quiere saber si su tarjeta de regalo se vinculará? ',
					style: TextStyle(
						fontSize: 13.0,
						color: Colors.grey[700],
						fontFamily: "Poppins-Light",
					),
					children: <TextSpan>[
						TextSpan(
							text: 'Aprende más',
							style: TextStyle(
								color: _isElegance ? darkColor : Color(0xFFC42036),
									fontFamily: "Poppins-Light",
								fontWeight: FontWeight.bold
							)
						),
					]
				)
			),
		);

		return Scaffold(
			backgroundColor: Colors.grey[100],
			appBar: Navbar(
				appBarTitle: 'Seleccione el tipo',
				leading: Icons.clear,
				context: context,
				isElegance: _isElegance
			),
			body: Container(
				padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: <Widget>[
						Button(
							color: _isElegance ? darkColor : Color(0xFFC42036),
							text: 'Tarjeta de crédito',
							textColor: Colors.white,
							redirect: CardCreate(),
						),
						Button(
							color: Colors.white,
							text: 'Tarjeta de dédito',
							textColor: _isElegance ? darkColor : Colors.grey[600],
							redirect: CardCreate(),
						),
						Button(
							color: Colors.white,
							text: 'Tarjeta de regalo',
							textColor: _isElegance ? darkColor : Colors.grey[600],
							redirect: CardCreate(),
						),
						_buildTextInfo,
					],
				),
			)
		);
	}
}