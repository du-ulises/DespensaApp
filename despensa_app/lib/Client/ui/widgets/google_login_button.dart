import 'package:despensaapp/Client/bloc/login/bloc/login_bloc.dart';
import 'package:despensaapp/Client/bloc/login/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
            left: 20.0,
            right: 20.0
        ),
        width: 300.0,
        height: 50.0,
        child: RaisedButton(
          color: Colors.white,
          splashColor: Colors.white10,
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).dispatch(
              LoginWithGooglePressed(),
            );
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          highlightColor: Color(0xFFFFFFFF),
          elevation: 0.0,
          highlightElevation: 8.0,
          disabledElevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Inicia sesión con Google',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2E3748),
                      fontFamily: "Gilroy-Light",
                      fontWeight: FontWeight.bold
                    ),
                  ),

                ),
              ],
            ),
          ),
        ),
    );
  }
}
