class ValidateName {
  bool validateName(String name) {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(name);
  }
}
