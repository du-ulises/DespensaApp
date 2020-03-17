import 'dart:async';
import 'dart:io';
import 'package:despensaapp/Client/bloc/register/bloc/register_event.dart';
import 'package:despensaapp/Client/bloc/register/bloc/register_state.dart';
import 'package:despensaapp/Client/repository/firebase_auth_api.dart';
import 'package:despensaapp/Client/model/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuthAPI _userRepository;

  RegisterBloc({@required FirebaseAuthAPI userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged && event is! NameChanged && event is! LastNameChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged || event is NameChanged || event is LastNameChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is LastNameChanged) {
      yield* _mapLastNameChangedToState(event.lastName);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password, event.name, event.lastName, event.date, event.image, event.phone);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapNameChangedToState(String name) async* {
    yield currentState.update(
      isNameValid: Validators.isValidName(name),
    );
  }

  Stream<RegisterState> _mapLastNameChangedToState(String lastName) async* {
    yield currentState.update(
      isLastNameValid: Validators.isValidLastName(lastName),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String password,
    String name,
    String lastName,
    String date,
    File image,
    [String phone]
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        email: email,
        password: password,
        name: name,
        lastName: lastName,
        date: date,
        image: image,
        phone: phone
      );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
