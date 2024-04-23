import 'dart:developer';

import 'package:exercicio_aula1/domain/account.dart';
import 'package:exercicio_aula1/infra/database/database_connection.dart';

sealed class AccountRepository {
  Future<Account> getAccountByEmail({required String email});
  Future<Account> getAccountById({required String accountId});
  Future<void> saveAccount({required Account account});
}

class AccountRepositoryDatabase implements AccountRepository {
  AccountRepositoryDatabase({
    required DatabaseConnection connection,
  }) : _connection = connection;

  final DatabaseConnection _connection;
  @override
  Future<Account> getAccountByEmail({required String email}) async {
    final conn = await _connection.instance;
    try {
      final accountData = await conn.execute(
        r'select * from cccat16.account where email = $1',
        parameters: email,
      );

      if (accountData.isEmpty) {
        throw Exception('User not found');
      }

      final row = accountData.first.toColumnMap();

      return Account.restore(
        row['account_id'].toString(),
        row['account_id'].toString(),
        row['email'].toString(),
        row['cpf'].toString(),
        row['car_plate'].toString(),
        isPassenger: bool.parse(
          row['is_passenger'].toString(),
        ),
        isDriver: bool.parse(
          row['is_driver'].toString(),
        ),
      );
    } on Exception catch (e, s) {
      log(
        'Erro a buscar usuário por email',
        error: e,
        stackTrace: s,
      );
      throw Exception('Erro a buscar usuário por email');
    } finally {
      await conn.close();
    }
  }

  @override
  Future<Account> getAccountById({required String accountId}) async {
    final conn = await _connection.instance;
    try {
      final accountData = await conn.execute(
        r'select * from cccat16.account where account_id = $1',
        parameters: accountId,
      );

      if (accountData.isEmpty) {
        throw Exception('User not found');
      }

      final row = accountData.first.toColumnMap();

      return Account.restore(
        row['account_id'].toString(),
        row['account_id'].toString(),
        row['email'].toString(),
        row['cpf'].toString(),
        row['car_plate'].toString(),
        isPassenger: bool.parse(
          row['is_passenger'].toString(),
        ),
        isDriver: bool.parse(
          row['is_driver'].toString(),
        ),
      );
    } on Exception catch (e, s) {
      log(
        'Erro a buscar usuário por id',
        error: e,
        stackTrace: s,
      );
      throw Exception('Erro a buscar usuário por id');
    } finally {
      await conn.close();
    }
  }

  @override
  Future<void> saveAccount({required Account account}) async {
    final conn = await _connection.instance;
    try {
      await conn.execute(
        r'insert into cccat16.account (account_id, name, email, cpf, car_plate, is_passenger, is_driver) values ($1, $2, $3, $4, $5, $6, $7)',
        parameters: [
          account.accountId,
          account.name,
          account.email,
          account.cpf,
          account.carPlate,
          account.isPassenger,
          account.isDriver,
        ],
      );
    } on Exception catch (e, s) {
      log(
        'Erro a buscar usuário por id',
        error: e,
        stackTrace: s,
      );
      throw Exception('Erro a buscar usuário por id');
    } finally {
      await conn.close();
    }
  }
}

class AccountRepositoryMemory implements AccountRepository {
  const AccountRepositoryMemory({
    this.accounts = const [],
  });

  final List<Account> accounts;

  @override
  Future<Account> getAccountByEmail({required String email}) async {
    final account = accounts
        .where(
          (account) => account.email == email,
        )
        .toList();
    return Future.value(account.first);
  }

  @override
  Future<Account> getAccountById({required String accountId}) {
    final account = accounts
        .where(
          (account) => account.accountId == accountId,
        )
        .toList();
    return Future.value(account.first);
  }

  @override
  Future<void> saveAccount({
    required Account account,
  }) async {
    accounts.add(account);
  }
}