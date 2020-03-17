import 'package:despensaapp/Client/bloc/register/bloc/register_bloc.dart';
import 'package:despensaapp/Client/repository/firebase_auth_api.dart';
import 'package:despensaapp/Client/ui/screens/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final FirebaseAuthAPI _userRepository;

  RegisterScreen({Key key, @required FirebaseAuthAPI userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          builder: (context) => RegisterBloc(userRepository: _userRepository),
          child: CreateAccountScreen(),
        ),
      ),
    );
  }
}
