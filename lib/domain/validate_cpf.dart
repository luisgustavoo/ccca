class ValidateCpf {
  final _factoFirstDigit = 10;
  final _factoSecondDigit = 11;

  bool validateCpf(String rawCpf) {
    final cpf = _removeNonDigits(rawCpf);
    if (!_isValideLength(cpf)) {
      return false;
    }
    if (_allDigitsEquals(cpf)) {
      return false;
    }
    final firstDigit = _calculateDigit(cpf: cpf, factor: _factoFirstDigit);
    final secondDigit = _calculateDigit(cpf: cpf, factor: _factoSecondDigit);
    return _extractDigit(cpf) == '$firstDigit$secondDigit';
  }

  String _removeNonDigits(String cpf) => cpf.replaceAll(RegExp(r'\D+'), '');

  bool _isValideLength(String cpf) => cpf.length == 11;

  bool _allDigitsEquals(String cpf) {
    final firstDigit = cpf[0];
    return cpf.split('').every((digit) => digit == firstDigit);
  }

  int _calculateDigit({
    required String cpf,
    required int factor,
  }) {
    var total = 0;
    for (var i = 0; i < cpf.length - 1; i++) {
      final digit = cpf[i];
      if (factor > 1) {
        total += (int.tryParse(digit) ?? 0) * factor--;
      }
    }
    final remainder = total % 11;
    return remainder < 2 ? 0 : 11 - remainder;
  }

  String _extractDigit(String cpf) => cpf.substring(9);
}
