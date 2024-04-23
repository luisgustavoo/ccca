class ValidateEmail {
  bool validateEmail(String email) {
    return RegExp(r'^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$')
        .hasMatch(email);
  }
}
