import 'package:exercicio_aula1/infra/http/account_controller.dart';
import 'package:exercicio_aula1/infra/http/https_server.dart';

Future<void> runApplication() async {
  final httpServer = ShelfAdapter();
  AccountController(httpServer);
  await httpServer.listen(8080);
  // print(validate('Luis Gustavo1'));
}
