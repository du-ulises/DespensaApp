import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_event.dart';
import 'package:despensaapp/Client/bloc/login/bloc/login_bloc.dart';
import 'package:despensaapp/Client/bloc/login/bloc/login_event.dart';
import 'package:despensaapp/Client/bloc/login/bloc/login_state.dart';
import 'package:despensaapp/Client/repository/firebase_auth_api.dart';
import 'package:despensaapp/Client/ui/widgets/create_account_button.dart';
import 'package:despensaapp/Client/ui/widgets/google_login_button.dart';
import 'package:despensaapp/Client/ui/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:despensaapp/widgets/gradient_back.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInScreen extends StatefulWidget {
  final FirebaseAuthAPI _userRepository;

  SignInScreen({Key key, @required FirebaseAuthAPI userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  State<SignInScreen> createState() => _SignInSreen();
}

class _SignInSreen extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //Initially password is obscure
  bool _obscureText = true;
  Icon _suffixIcon = Icon(Icons.remove_red_eye);

  LoginBloc _loginBloc;

  FirebaseAuthAPI get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }
  double screenWidth;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    //clientBloc = BlocProvider.of(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Fallo de inicio de sesión'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Iniciando sesión...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final logIn = Flexible(
            child: Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 0),
              width: screenWidth,
              child: Text(
                "Inicia sesión",
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: "Gilroy-ExtraBold",
                    color: Color(0xFF2E3748),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          );
          final or = Text(
            "o",
            style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Gilroy-Light",
                color: Color(0xFF2E3748),
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          );

          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                GradientBack(height: null),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 80.0),
                      child: Column(
                        children: <Widget>[
                          Image(
                              image: AssetImage("assets/images/circle-outline-red.png"),
                              height: 45.0),
                          logIn,
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 170.0, bottom: 20.0),
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: 300.0,
                            margin: EdgeInsets.only(top: 10.0),
                            child: TextFormField(
                              controller: _emailController,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Gilroy-Light",
                                  color: Color(0xFF2E3748),
                                  fontWeight: FontWeight.bold
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 18, top: 10),
                                hintText: "Correo electrónico",
                                suffixIcon: Icon(Icons.email),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFC42036),width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                              ),
                              autovalidate: true,
                              autocorrect: false,
                            ),
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 15.0,
                                      offset: Offset(0.0, 7.0)
                                  )
                                ]
                            ),
                          ),
                          Container(
                            width: 300.0,
                            //height: 50.0,
                            margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                            child: TextFormField(
                              controller: _passwordController,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Gilroy-Light",
                                color: Color(0xFF2E3748),
                                fontWeight: FontWeight.bold
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 18, top: 10),
                                hintText: "Contraseña",
                                suffixIcon: IconButton(
                                  icon: _suffixIcon,
                                  onPressed: (){
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                    if(_obscureText){
                                      setState(() {
                                        _suffixIcon = Icon(Icons.remove_red_eye);
                                      });
                                    }else{
                                      setState(() {
                                        _suffixIcon = Icon(Icons.lock);
                                      });
                                    }
                                  },
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFC42036),width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                              ),
                              obscureText: _obscureText,
                              autovalidate: true,
                              autocorrect: false,
                            ),
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 15.0,
                                      offset: Offset(0.0, 7.0)
                                  )
                                ]
                            ),
                          ),
                          Container(
                              width: 200.0,
                              child: Button(
                                text: "Inicia sesión",
                                onPressed: isLoginButtonEnabled(state)
                                    ? _onFormSubmitted
                                    : null,
                                width: 200.0,
                                heigth: 40.0,
                              )
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: <Widget>[
                                CreateAccountButton(userRepository: _userRepository),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: or,
                          ),
                          GoogleLoginButton(),

                          Container(
                              margin: const EdgeInsets.all(20.0),
                              width: screenWidth,
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      fontFamily: "Poppins-ExtraBold",
                                      color: Color(0xFFC42036),
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Despensa App",
                                        style: TextStyle(
                                          fontSize: 40.0,
                                          fontFamily: "Poppins-Bold",
                                          color: Color(0xFF2E3748),
                                        ),
                                      ),
                                      TextSpan(text: '.'),
                                    ],
                                  ),
                                ),
                              )
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: screenWidth,
                            child: InkWell(
                              onTap: _launchNoticeOfPrivacy,
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: "Gilroy-Light",
                                      color: Color(0xFF2E3748),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: '- '),
                                      TextSpan(
                                          text: 'Términos y Condiciones',
                                          style: TextStyle(
                                            color: Color(0xFFC42036),
                                          )
                                      ),
                                      TextSpan(text: ' -'),
                                    ],
                                  ),
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.dispatch(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  _launchNoticeOfPrivacy() async {
    const url = 'https://www.walmartmexico.com/terminos-de-uso-y-condiciones';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
