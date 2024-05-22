import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:ccca/application/usecase/signup.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  const port = '8080';
  const host = 'http://0.0.0.0:$port';
  // late Process p;
  // setUp(() async {
  //   p = await Process.start(
  //     'dart',
  //     [
  //       'run',
  //       'bin/server.dart',
  //     ],
  //     environment: {
  //       'PORT': '8080',
  //     },
  //   );
  //   // Wait for server to start and print to stdout.
  //   await p.stdout.first;
  // });

  // tearDown(() => p.kill());

  test('Deve criar uma conta para o passageiro', () async {
    final input = <String, dynamic>{
      'name': 'John Doe',
      'email': 'john.doe${math.Random().nextInt(1000)}@gmail.com',
      'cpf': '87748248800',
      'isPassenger': true,
    };

    final responseSignup = await post(
      Uri.parse('$host/signup'),
      body: jsonEncode(input),
    );

    expect(responseSignup.statusCode, 200);
    final signupJson = jsonDecode(responseSignup.body) as Map<String, dynamic>;
    final outputSignup = SignupOutput(
      accountId: signupJson['accountId'].toString(),
    );
    expect(outputSignup.accountId, isNotNull);
    final responseGetAccount = await get(
      Uri.parse('$host/accounts/${outputSignup.accountId}'),
    );
    final outputGetAccount =
        jsonDecode(responseGetAccount.body) as Map<String, dynamic>;
    expect(outputGetAccount['name'].toString(), input['name'].toString());
    expect(outputGetAccount['email'].toString(), input['email'].toString());
    expect(outputGetAccount['cpf'].toString(), input['cpf'].toString());
  });

  test('Não deve criar uma conta para o passageiro se o nome for inválido',
      () async {
    final input = <String, dynamic>{
      'name': 'John',
      'email': 'john.doe${math.Random().nextInt(1000)}@gmail.com',
      'cpf': '87748248800',
      'isPassenger': true,
    };
    final responseSignup = await post(
      Uri.parse('$host/signup'),
      body: jsonEncode(input),
    );
    expect(responseSignup.statusCode, 422);
    final outputSignup =
        jsonDecode(responseSignup.body) as Map<String, dynamic>;
    expect(outputSignup['message'], 'Invalid name');
  });
}
