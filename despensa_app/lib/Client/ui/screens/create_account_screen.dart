
import 'dart:io';
import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:despensaapp/Client/bloc/authentication_bloc/authentication_event.dart';
import 'package:despensaapp/Client/bloc/register/bloc/register_bloc.dart';
import 'package:despensaapp/Client/bloc/register/bloc/register_event.dart';
import 'package:despensaapp/Client/bloc/register/bloc/register_state.dart';
import 'package:despensaapp/Client/ui/widgets/login_button.dart';
import 'package:despensaapp/widgets/floating_action_button_green.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:despensaapp/widgets/gradient_back.dart';
import 'package:despensaapp/widgets/title_header.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String MIN_DATETIME = '1920-01-01';
const String MAX_DATETIME = '2021-11-25';
const String INIT_DATETIME = '2000-06-15';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreen createState() => _CreateAccountScreen();
}

class _CreateAccountScreen extends State<CreateAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  //Initially password is obscure
  bool _obscureText = true;
  Icon _suffixIcon = Icon(Icons.remove_red_eye);

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _nameController.text.isNotEmpty && _lastNameController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    print(_image.path);
  }

  bool _showTitle = true;

  DateTimePickerLocale _locale = DateTimePickerLocale.es;

  String _format = 'dd-MMMM-yyyy';
  TextEditingController _formatCtrl = TextEditingController();

  DateTime _dateTime;

  bool _isElegance = false;

  Future<Null> getSharedPrefs() async {
    SharedPreferences theme = await SharedPreferences.getInstance();
    bool isElegance = (theme.getBool("Elegance") ?? false);
    setState(() {
      _isElegance = isElegance;
    });
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _nameController.addListener(_onNameChanged);
    _lastNameController.addListener(_onLastNameChanged);
    _formatCtrl.text = _format;
    _dateTime = DateTime.parse(INIT_DATETIME);
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registrando...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Falla de registro'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                GradientBack(height: null),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    //APP BAR
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 25.0, left: 5.0),
                        child: SizedBox(
                          height: 35.0,
                          width: 35.0,
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Color(0xFFC42036),
                                size: 35,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                      ),
                      Flexible(
                          child: Container(
                            padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 10.0),
                            child: TitleHeader(title: "Crear cuenta"),
                          ))
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 80.0, bottom: 20.0),
                  child: Form(
                    child: ListView(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              alignment: Alignment(1.5, 1.5),
                              children: <Widget>[
                                Container(
                                  width: 90.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFC42036),
                                          width: 2.0,
                                          style: BorderStyle.solid),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: _image == null ? AssetImage("assets/images/circle-outline-red.png") : FileImage(_image)
                                      )
                                  ),
                                ),
                                FloatingActionButtonGreen(
                                    iconData: Icons.add_photo_alternate,
                                    onPressed: getImage,
                                    isElegance: _isElegance
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          //TextField Cellphone
                          margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
                          width: 300.0,
                          child: TextFormField(
                            controller: _nameController,
                            style: TextStyle(
                              fontSize: 15.0,
                                fontFamily: "Gilroy-Light",
                                color: Color(0xFF2E3748),
                                fontWeight: FontWeight.bold
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 18, top: 10),
                              hintText: "Nombre",
                              prefixIcon: Icon(Icons.account_circle),
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
                            validator: (_) {
                              return !state.isNameValid ? 'Nombre inválido' : null;
                            },
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
                          //TextField Cellphone
                          margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
                          width: 300.0,
                          child: TextFormField(
                            controller: _lastNameController,
                            style: TextStyle(
                              fontSize: 15.0,
                                fontFamily: "Gilroy-Light",
                                color: Color(0xFF2E3748),
                                fontWeight: FontWeight.bold
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 18, top: 10),
                              hintText: "Apellidos",
                              prefixIcon: Icon(Icons.group),
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
                            validator: (_) {
                              return !state.isLastNameValid ? 'Apellidos inválidos' : null;
                            },
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
                          //TextField Cellphone
                            margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                            padding: EdgeInsets.only(right: 20.0, left: 20.0),
                            width: 300.0,
                            child: TextFormField(
                              controller: _emailController,
                              style: TextStyle(
                                fontSize: 15.0,
                                  fontFamily: "Gilroy-Light",
                                  color: Color(0xFF2E3748),
                                  fontWeight: FontWeight.bold
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 18, top: 10),
                                hintText: "Correo electrónico",
                                prefixIcon: Icon(Icons.email),
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
                              validator: (_) {
                                return !state.isEmailValid ? 'Email inválido' : null;
                              },
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
                          //TextField Password
                          margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
                          width: 300.0,
                          child: TextFormField(
                            controller: _passwordController,
                            style: TextStyle(
                              fontSize: 15.0,
                                fontFamily: "Gilroy-Light",
                                color: Color(0xFF2E3748),
                                fontWeight: FontWeight.bold
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 18, top: 10),
                              hintText: "Contraseña",
                              prefixIcon: IconButton(
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
                            validator: (_) {
                              return !state.isPasswordValid ? 'Contraseña invalida' : null;
                            },
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
                          //TextField Cellphone
                          margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
                          width: 300.0,
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              fontSize: 15.0,
                                fontFamily: "Gilroy-Light",
                                color: Color(0xFF2E3748),
                                fontWeight: FontWeight.bold
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 18, top: 10),
                              hintText: "Teléfono",
                              prefixIcon: Icon(Icons.phone),
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

                        InkWell(
                          onTap: () {
                            _showDatePicker();// Call Function that has showDatePicker()
                          },
                          child: IgnorePointer(
                            child:  Container(
                              //TextField Cellphone
                              margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                              padding: EdgeInsets.only(right: 20.0, left: 20.0),
                              width: 300.0,
                              child: TextFormField(
                                controller: _dateController,
                                style: TextStyle(
                                  fontSize: 15.0,
                                    fontFamily: "Gilroy-Light",
                                    color: Color(0xFF2E3748),
                                    fontWeight: FontWeight.bold
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 18, top: 10),
                                  hintText: '${_dateTime.day.toString().padLeft(2, '0')} / ${_dateTime.month.toString().padLeft(2, '0')} / ${_dateTime.year}',
                                  prefixIcon: Icon(Icons.cake),
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
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              //width: 180.0,
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: Button(
                                text: "Registrarse",
                                onPressed: isRegisterButtonEnabled(state)
                                    ? _onFormSubmitted
                                    : null,
                                width: 200.0,
                                heigth: 35.0,
                              )
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
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
    _nameController.dispose();
    _lastNameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    if(_image != null){
      _registerBloc.dispatch(
        EmailChanged(email: _emailController.text),
      );
    }
  }

  void _onPasswordChanged() {
    _registerBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onNameChanged() {
    _registerBloc.dispatch(
      NameChanged(name: _nameController.text),
    );
  }

  void _onLastNameChanged() {
    _registerBloc.dispatch(
      LastNameChanged(lastName: _lastNameController.text),
    );
  }

  void _onFormSubmitted() {
    print('email: ' + _emailController.text + ', password: ' + _passwordController.text + ', name: ' + _nameController.text + ', lastName: ' + _lastNameController.text + ', date: ' + _dateTime.toString() + ', image: ' + _image.path);
    _registerBloc.dispatch(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        lastName: _lastNameController.text,
        date: _dateTime.toString(),
        image: _image,
        phone: _phoneController.text,
      ),
    );
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
        confirm: Text('Hecho', style: TextStyle(color: Colors.cyan)),
        cancel: Text('Cancelar', style: TextStyle(color: Colors.red)),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.now(),
      initialDateTime: _dateTime,
      dateFormat: _format,
      locale: _locale,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
    );
  }
}
