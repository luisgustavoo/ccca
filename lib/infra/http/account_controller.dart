import 'dart:convert';

import 'package:ccca/application/usecase/get_account.dart';
import 'package:ccca/application/usecase/signup.dart';
import 'package:ccca/infra/http/https_server.dart';
import 'package:shelf/shelf.dart';

class AccountController {
  AccountController(
    HttpsServer httpServer,
    Signup signupInstance,
    GetAccount getAccount,
  )   : _httpServer = httpServer,
        _signup = signupInstance,
        _getAccount = getAccount {
    _httpServer
      ..register(
        'GET',
        '/accounts',
        accounts,
      )
      ..register(
        'POST',
        '/signup',
        signup,
      );
  }

  final HttpsServer _httpServer;
  final Signup _signup;
  final GetAccount _getAccount;

  Future<Response> accounts(Request request) async {
    final requestData =
        jsonDecode(await request.readAsString()) as Map<String, dynamic>;
    final input = SignupInput(
      name: requestData['name'].toString(),
      email: requestData['email'].toString(),
      cpf: requestData['cpf'].toString(),
    );
    final signup = await _signup.execute(input);
    final output = <String, dynamic>{
      'accountId': signup.accountId,
    };

    return Response.ok(jsonEncode(output));
  }

  Future<Response> signup(Request request) async {
    final requestData =
        jsonDecode(await request.readAsString()) as Map<String, dynamic>;

    final input = GetAccountInput(
      accountId: requestData['accountId'].toString(),
    );
    final account = await _getAccount.execute(input);
    final output = <String, dynamic>{
      'accountId': account?.accountId,
      'cpf': account?.cpf,
      'name': account?.name,
      'email': account?.email,
      'carPlate': account?.carPlate,
      'isPassenger': account?.isPassenger,
      'isDriver': account?.isDriver,
    };

    return Response.ok(jsonEncode(output));
  }
}
