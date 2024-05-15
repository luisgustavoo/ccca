import 'package:ccca/application/usecase/get_account.dart';
import 'package:ccca/application/usecase/signup.dart';
import 'package:ccca/infra/database/database_connection.dart';
import 'package:ccca/infra/gateway/mailer_gateway.dart';
import 'package:ccca/infra/http/account_controller.dart';
import 'package:ccca/infra/http/https_server.dart';
import 'package:ccca/infra/repository/account_repository.dart';

Future<void> runApplication() async {
  final httpServer = ShelfAdapter();
  final connection = PgAdapter();
  final accountRepository = AccountRepositoryDatabase(connection: connection);

  final mailerGateway = MailerGatewayMemory();
  final signup = Signup(
    accountRepository: accountRepository,
    mailerGateway: mailerGateway,
  );
  final getAccount = GetAccount(accountRepository: accountRepository);
  AccountController(
    httpServer,
    signup,
    getAccount,
  );
  await httpServer.listen(8080);
}
