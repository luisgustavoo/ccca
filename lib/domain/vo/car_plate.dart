class CarPlate {
  CarPlate(String carPlate) : _value = carPlate {
    if (!validate(_value)) {
      throw Exception('Invalid car plate');
    }
    _value = carPlate;
  }

  late final String _value;

  String getValue() {
    return _value;
  }

  bool validate(String carPlate) {
    return RegExp(r'^[A-Z]{3}[0-9]{4}$').hasMatch(carPlate);
  }
}
