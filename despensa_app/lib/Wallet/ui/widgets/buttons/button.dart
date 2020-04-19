import 'package:flutter/material.dart';
import '../../../blocs/bloc_provider.dart';
import '../../../blocs/card_bloc.dart';

class Button extends StatelessWidget {
  Button({this.color, this.text, this.textColor, this.redirect});

  final String text;
  final Color color;
  final Color textColor;
  final Widget redirect;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 10.0),
				child: RaisedButton(
					padding: EdgeInsets.only(top: 10, bottom: 10),
					elevation: 0,

					highlightElevation: 10,
					splashColor: Colors.white70,
					onPressed: () {
						var blocProviderCardCreate = BlocProvider(
							bloc: CardBloc(),
							child: redirect,
						);

						blocProviderCardCreate.bloc.selectCardType(text);
						Navigator.push(
								context,
								MaterialPageRoute(
										builder: (context) => blocProviderCardCreate));
					},
					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
					color: color,
					child: Row(
						mainAxisSize: MainAxisSize.max,
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Text(
								text,
								style: TextStyle(
										fontSize: 13,
										fontFamily: "Poppins-SemiBold",
										color: textColor,
								),
							),

						],
					),
				),
		);
  }
}
