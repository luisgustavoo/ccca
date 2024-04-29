import 'dart:math' as math;
import 'package:ccca/application/usecase/get_account.dart';
import 'package:ccca/application/usecase/signup.dart';
import 'package:ccca/infra/geteway/mailer_gateway.dart';
import 'package:ccca/infra/repository/account_repository.dart';
import 'package:test/test.dart';

void main() {
  late Signup signup;
  late GetAccount getAccount;

  setUp(() {
    final accountRepository = AccountRepositoryMemory();
    final mailerGateway = MailerGatewayMemory();
    signup = Signup(
      accountRepository: accountRepository,
      mailerGateway: mailerGateway,
    );
    getAccount = GetAccount(accountRepository: accountRepository);
  });

  test(
    'Deve criar uma conta para o passageiro',
    () async {
      final input = SignupInput(
        name: 'John Doe',
        email: 'john.doe${math.Random().nextInt(1000)}@gmail.com',
        cpf: '87748248800',
      );

      final outputSignup = await signup.execute(input);
      expect(outputSignup.accountId, isNotNull);
      final outputGetAccount = await getAccount.execute(
        GetAccountInput(
          accountId: outputSignup.accountId,
        ),
      );
      expect(outputGetAccount?.name, input.name);
      expect(outputGetAccount?.email, input.email);
      expect(outputGetAccount?.cpf, input.cpf);
    },
    // skip: true,
  );

  test(
    'Deve criar uma conta para o motorista',
    () async {
      final input = SignupInput(
        name: 'John Doe',
        email: 'john.doe${math.Random().nextInt(1000)}@gmail.com',
        cpf: '87748248800',
        carPlate: 'AAA9999',
        isDriver: true,
      );
      final outputSignup = await signup.execute(input);
      expect(outputSignup.accountId, isNotNull);
      final outputGetAccount = await getAccount.execute(
        GetAccountInput(
          accountId: outputSignup.accountId,
        ),
      );
      expect(outputGetAccount?.name, input.name);
      expect(outputGetAccount?.email, input.email);
      expect(outputGetAccount?.cpf, input.cpf);
    },
    // skip: true,
  );
}
