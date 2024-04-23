import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  const port = '8080';
  const host = 'http://0.0.0.0:$port';
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('Deve criar uma conta com sucesso', () async {
    final input = <String, dynamic>{
      'name': 'John Doe',
      'email': 'john.doe${math.Random().nextInt(10)}@gmail.com',
      'cpf': '87748248800',
      'isPassenger': true,
    };
    final output = await post(
      Uri.parse('$host/signup'),
      body: jsonEncode(input),
    );
    log('${output.statusCode} ${output.body}');
  });
}
