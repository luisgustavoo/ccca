class Name {
  Name(String name) : _value = name {
    if (!validate(_value)) {
      throw Exception('Invalid name');
    }
    _value = name;
  }
  late final String _value;

  bool validate(String name) {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(name);
  }
}
