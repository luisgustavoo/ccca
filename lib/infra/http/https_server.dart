import 'dart:developer';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

abstract class HttpsServer {
  void register(
    String method,
    String url,
    Future<Response> Function(Request) callback,
  );
  Future<void> listen(int port);
}

class ShelfAdapter implements HttpsServer {
  ShelfAdapter() : _router = Router();

  late final Router _router;

  @override
  Future<void> listen(int port) async {
    //   GetIt.instance.registerSingleton<DatabaseConnection>(
    //   DatabaseConnection(),
    // );
    final ip = InternetAddress.anyIPv4;

    final handler =
        const Pipeline().addMiddleware(logRequests()).addHandler(_router.call);
    final server = await serve(handler, ip, port);
    log('Server listening on port ${server.port}');
  }

  @override
  void register(
    String method,
    String url,
    Future<Response> Function(Request) callback,
  ) {
    switch (method.toUpperCase()) {
      case 'GET':
        _router.get(url, callback);
      case 'POST':
        _router.post(url, callback);
      case 'PUT':
        _router.put(url, callback);
      case 'DELETE':
        _router.delete(url, callback);
      case 'PATH':
        _router.patch(url, callback);
      default:
        _router.options(url, callback);
        break;
    }
  }
}
