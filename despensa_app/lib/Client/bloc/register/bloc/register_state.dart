import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isNameValid;
  final bool isLastNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid && isNameValid && isLastNameValid;

  RegisterState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isNameValid,
    @required this.isLastNameValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isNameValid: true,
      isLastNameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isNameValid: true,
      isLastNameValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isNameValid: true,
      isLastNameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isNameValid: true,
      isLastNameValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isNameValid,
    bool isLastNameValid
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isNameValid: isNameValid,
      isLastNameValid: isLastNameValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isNameValid,
    bool isLastNameValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,  
      isNameValid: $isNameValid,
      isLastNameValid: $isLastNameValid,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
