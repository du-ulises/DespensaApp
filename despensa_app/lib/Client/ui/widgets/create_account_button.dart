import 'package:despensaapp/Client/repository/firebase_auth_api.dart';
import 'package:despensaapp/Client/ui/screens/register_screen.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final FirebaseAuthAPI _userRepository;

  CreateAccountButton({Key key, @required FirebaseAuthAPI userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return RegisterScreen(userRepository: _userRepository);
            }),
          );
        },
        splashColor: Colors.white70,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
                fontSize: 16.0,
                fontFamily: "Gilroy-Light",
                color: Color(0xFF2E3748),
                fontWeight: FontWeight.bold
            ),
            children: <TextSpan>[
              TextSpan(text: '¿No tienes una cuenta? '),
              TextSpan(
                  text: 'Regístrate',
                  style: TextStyle(
                    color: Color(0xFFC42036),
                  )
              ),
            ],
          ),
        ));
  }
}
