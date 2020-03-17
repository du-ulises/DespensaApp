import 'dart:async';
import 'package:despensaapp/Client/model/client.dart';
import 'package:despensaapp/Client/repository/firebase_auth_api.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseAuthAPI _userRepository;

  LoginBloc({
    @required FirebaseAuthAPI userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: true,
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: true,
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _userRepository.signInWithGoogle().then((FirebaseUser client) async {
        final String CLIENTS = "clients";
        final Firestore _db = Firestore.instance;
        DocumentSnapshot ds = await _db.collection(CLIENTS).document(client.uid).get();
        if(client.metadata.creationTimestamp == client.metadata.lastSignInTimestamp || ds.exists==false) {
          _userRepository.updateClientData(Client(
              uid: client.uid,
              email: client.providerData[1].email,
              name: client.providerData[1].displayName,
              photoURL: client.providerData[1].photoUrl,
              date: ""
          ));
        }
      });
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
