import 'package:exercicio_aula1/domain/account.dart';
import 'package:exercicio_aula1/infra/geteway/mailer_gateway.dart';
import 'package:exercicio_aula1/infra/repository/account_repository.dart';

class Signup {
  Signup({
    required AccountRepository accountRepository,
    required MailerGateway mailerGateway,
  })  : _accountRepository = accountRepository,
        _mailerGateway = mailerGateway;

  final AccountRepository _accountRepository;
  final MailerGateway _mailerGateway;

  Future<SignupOutput> execute(SignupInput input) async {
    final existingAccount = await _accountRepository.getAccountByEmail(
      email: input.email,
    );

    if (existingAccount?.accountId.isNotEmpty ?? false) {
      throw Exception('Account already exists');
    }

    final account = Account.create(
      input.name,
      input.email,
      input.cpf,
      input.carPlate,
      isPassenger: input.isPassenger,
      isDriver: input.isDriver,
    );

    await _accountRepository.saveAccount(account: account);
    await _mailerGateway.send(
      recipient: account.email,
      subject: 'Welcome!',
      content: '',
    );

    return SignupOutput(accountId: account.accountId);
  }
}

class SignupInput {
  SignupInput({
    required this.name,
    required this.email,
    required this.cpf,
    this.carPlate,
    this.isPassenger = false,
    this.isDriver = false,
  });

  final String name;
  final String email;
  final String cpf;
  final String? carPlate;
  final bool isPassenger;
  final bool isDriver;
}

class SignupOutput {
  SignupOutput({
    required this.accountId,
  });

  final String accountId;
}
