import 'package:ccca/domain/vo/cpf.dart';
import 'package:test/test.dart';

void main() {
  test('Deve testar um cpf válido', () async {
    expect(Cpf('97456321558'), isNotNull);
  });

  test('Deve testar um cpf inválido', () async {
    expect(
      () => Cpf('1234566789123456789'),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString().replaceAll('Exception: ', ''),
          'message',
          'Invalid cpf',
        ),
      ),
    );
  });
}
