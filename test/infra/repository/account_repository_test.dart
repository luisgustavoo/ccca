import 'dart:math' as math;

import 'package:exercicio_aula1/domain/account.dart';
import 'package:exercicio_aula1/infra/database/database_connection.dart';
import 'package:exercicio_aula1/infra/repository/account_repository.dart';
import 'package:test/test.dart';

void main() {
  test('Deve salvar um registro na tabela account e consultar por id',
      () async {
    final account = Account.create(
      'John Doe',
      'john.doe${math.Random().nextInt(10)}@gmail.com',
      '87748248800',
      '',
      isPassenger: true,
    );
    final connection = PgAdapter();
    final accountRepository = AccountRepositoryDatabase(
      connection: connection,
    );
    await accountRepository.saveAccount(account: account);
    final accountById = await accountRepository.getAccountById(
      accountId: account.accountId,
    );
    expect(accountById.accountId, account.accountId);
    expect(accountById.name, account.name);
    expect(accountById.email, account.email);
    expect(accountById.cpf, account.cpf);
    await connection.close();
  });
}
