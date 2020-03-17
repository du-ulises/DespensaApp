class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  static final RegExp _nameRegExp = RegExp(
    r'^[a-z-A-Z\D]+$',
  );
  static final RegExp _lastNameRegExp = RegExp(
    r'^[a-z-A-Z\D]+$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidName(String name) {
    return _nameRegExp.hasMatch(name);
  }

  static isValidLastName(String lastName) {
    return _lastNameRegExp.hasMatch(lastName);
  }
}
