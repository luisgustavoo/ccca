import 'package:exercicio_aula1/infra/http/https_server.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'account_controller.g.dart';

class AccountController {
  AccountController(HttpsServer httpServer) : _httpServer = httpServer {
    _httpServer
      ..register(
        'GET',
        '/hello',
        hello,
      )
      ..register(
        'POST',
        '/signup',
        signup,
      );
  }

  final HttpsServer _httpServer;

  // @Route.post('/signup')
  Future<Response> hello(Request request) async {
    return Response.ok('hello');
  }

  Future<Response> signup(Request request) async {
    return Response.ok('signup');
  }

  // Router get router => _$AccountControllerRouter(this);
}
