import 'package:ccca/infra/http/account_controller.dart';
import 'package:ccca/infra/http/https_server.dart';

Future<void> runApplication() async {
  final httpServer = ShelfAdapter();
  AccountController(httpServer);
  await httpServer.listen(8080);
  // print(validate('Luis Gustavo1'));
}
