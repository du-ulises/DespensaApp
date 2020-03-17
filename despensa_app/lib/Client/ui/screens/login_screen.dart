import 'package:despensaapp/Client/bloc/login/bloc/login_bloc.dart';
import 'package:despensaapp/Client/repository/firebase_auth_api.dart';
import 'package:despensaapp/Client/ui/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuthAPI _userRepository;

  LoginScreen({Key key, @required FirebaseAuthAPI userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        builder: (context) => LoginBloc(userRepository: _userRepository),
        child: SignInScreen(userRepository: _userRepository),
      ),
    );
  }
}
