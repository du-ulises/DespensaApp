import 'package:despensaapp/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Client/bloc/authentication_bloc/authentication_bloc.dart';
import 'Client/bloc/authentication_bloc/authentication_event.dart';
import 'Client/bloc/authentication_bloc/authentication_state.dart';
import 'Client/bloc/simple_bloc_delegate.dart';
import 'Client/repository/firebase_auth_api.dart';
import 'Client/ui/screens/login_screen.dart';

import 'utils/class_builder.dart';

import 'package:geolocator/geolocator.dart';
import 'package:despensaapp/Client/model/place.dart';
import 'package:despensaapp/Client/ui/screens/search.dart';
import 'package:despensaapp/Client/services/geolocator_service.dart';
import 'package:despensaapp/Client/services/places_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ClassBuilder.registerClasses();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final FirebaseAuthAPI userRepository = await FirebaseAuthAPI();
  //Lock Orientation Screen configuration
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {

    runApp(
      BlocProvider(
        builder: (context) => AuthenticationBloc(userRepository: userRepository)
          ..dispatch(AppStarted()),
        child: MyApp(userRepository: userRepository),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  final FirebaseAuthAPI _userRepository;

  MyApp({Key key, @required FirebaseAuthAPI userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin{

  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        FutureProvider(create: (context) {
          ImageConfiguration configuration = createLocalImageConfiguration(context);
          return BitmapDescriptor.fromAssetImage(configuration, 'assets/images/marker.png');
        }),
        ProxyProvider2<Position,BitmapDescriptor,Future<List<Place>>>(
          update: (context,position,icon,places){
            return (position !=null) ? placesService.getPlaces(position.latitude, position.longitude,icon) :null;
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Despensa App',
        theme: ThemeData(
          primaryColor: Color(0xFFC42036),
          primaryColorDark: Color(0xFF2E3748),
          //primarySwatch: Colors.black,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Unauthenticated) {
              return LoginScreen(userRepository: widget._userRepository);
            }
            if (state is Authenticated) {
              return Nav();
            }
            return LoginScreen(userRepository: widget._userRepository);
          },
        ),
      )
    );
  }
}