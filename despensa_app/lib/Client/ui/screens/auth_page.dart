import 'package:flutter/material.dart';
import 'package:despensaapp/Client/ui/widgets/circle_button.dart';
import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      child: Material(
                        shadowColor: Colors.transparent,
                        color: Colors.transparent,
                        child: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Cerrar sesión'),
                      CircleButton(true, Icons.exit_to_app, 20.0, Color.fromRGBO(255, 255, 255, 0.6), () {
                        BlocProvider.of<AuthenticationBloc>(context).dispatch(
                          LoggedOut(),
                        );
                        Navigator.of(context).pop();
                      },"Cerrar sesión"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
