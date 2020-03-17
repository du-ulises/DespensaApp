import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class NameChanged extends RegisterEvent {
  final String name;

  NameChanged({@required this.name}) : super([name]);

  @override
  String toString() => 'NameChanged { name :$name }';
}

class LastNameChanged extends RegisterEvent {
  final String lastName;

  LastNameChanged({@required this.lastName}) : super([lastName]);

  @override
  String toString() => 'LastNameChanged { lastname :$lastName }';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String name;
  final String lastName;
  final String date;
  final File image;
  final String phone;

  Submitted({@required this.email, @required this.password, @required this.name, @required this.lastName, @required this.date, @required this.image, this.phone})
      : super([email, password, name, lastName, date, image, phone]);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password, name: $name, lastName: $lastName, date: $date, image}';
  }
}