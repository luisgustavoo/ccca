import 'package:exercicio_aula1/domain/account.dart';
import 'package:exercicio_aula1/infra/repository/account_repository.dart';

class GetAccount {
  GetAccount({
    required AccountRepository accountRepository,
  }) : _accountRepository = accountRepository;

  final AccountRepository _accountRepository;

  Future<Account?> execute(GetAccountInput input) async {
    final account = await _accountRepository.getAccountById(
      accountId: input.accountId,
    );
    return account;
  }
}

class GetAccountInput {
  GetAccountInput({
    required this.accountId,
  });

  final String accountId;
}
