import 'package:exercicio_aula1/domain/validate_cpf.dart';
import 'package:test/test.dart';

void main() {
  late ValidateCpf validateCpf;

  setUp(() {
    validateCpf = ValidateCpf();
  });

  test('Deve testar um cpf válido ...', () async {
    const rawCpf = '974.563.215-58';
    final isValid = validateCpf.validateCpf(rawCpf);
    expect(isValid, true);
  });

  test('Deve testar um cpf inválido ...', () async {
    const rawCpf = '111.111.111-11';
    final isValid = validateCpf.validateCpf(rawCpf);
    expect(isValid, false);
  });
}
