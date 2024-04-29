import 'package:ccca/domain/vo/cpf.dart';
import 'package:postgres/messages.dart';
import 'package:test/test.dart';

void main() {
  test('Deve testar um cpf válido', () async {
    expect(Cpf('97456321558'), isNotNull);
  });

  test('Deve testar um cpf inválido', () async {
    try {
      Cpf('1234566789123456789');
    } on Exception catch (e) {
      expect(e, isNotNull);
    }
    // expect(
    //   Cpf('1234566789123456789'),
    //   Exception('Invalid cpf'),
    // );
  });
}
