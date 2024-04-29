class Email {
  Email(String email) : _value = email {
    if (!validate(_value)) {
      throw Exception('Invalid email');
    }
    _value = email;
  }
  late final String _value;

  String getValue() {
    return _value;
  }

  bool validate(String email) {
    return RegExp(r'^[a-z0-9._%+-]+@([a-z0-9-]+\.)+[a-z]{2,4}$')
        .hasMatch(email);
  }
}
