import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:ccca/application/usecase/signup.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
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

  test('Deve criar uma conta para o passageiro', () async {
    final input = <String, dynamic>{
      'name': 'John Doe',
      'email': 'john.doe${math.Random().nextInt(1000)}@gmail.com',
      'cpf': '87748248800',
      'isPassenger': true,
    };

    final responseSignup = await post(
      Uri.parse('http://localhost:8080/signup'),
      body: input,
    );
    // expect(responseSignup.statusCode, 200);
    // final signupJson = jsonDecode(responseSignup.body) as Map<String, dynamic>;
    // final outputSignup = SignupOutput(
    //   accountId: signupJson['accountId'].toString(),
    // );
    // expect(outputSignup, isNotNull);
  });
}
