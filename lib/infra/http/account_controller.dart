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
        '/accounts/<accountId>',
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

  Future<Response> accounts(Request request, String accountId) async {
    final input = GetAccountInput(
      accountId: accountId,
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

  Future<Response> signup(Request request) async {
    try {
      final requestData =
          jsonDecode(await request.readAsString()) as Map<String, dynamic>;

      final isDriver = bool.tryParse(
            requestData['isDriver'].toString(),
          ) ??
          false;

      final hasCarPlate =
          (requestData['carPlate'] as String?)?.isNotEmpty ?? false;

      if (isDriver && !hasCarPlate) {
        return Response.badRequest(
          body: jsonEncode(
            {'message': 'Parameter carPlate is required'},
          ),
        );
      }

      final input = SignupInput(
        name: requestData['name'].toString(),
        email: requestData['email'].toString(),
        cpf: requestData['cpf'].toString(),
        carPlate: requestData['carPlate'] as String?,
        isPassenger: bool.tryParse(
              requestData['isPassenger'].toString(),
            ) ??
            false,
        isDriver: bool.tryParse(
              requestData['isDriver'].toString(),
            ) ??
            false,
      );
      final signup = await _signup.execute(input);
      final output = <String, dynamic>{
        'accountId': signup.accountId,
      };

      return Response.ok(jsonEncode(output));
    } on Exception catch (e) {
      return Response(
        422,
        body: jsonEncode(
          {
            'message': e,
          },
        ),
      );
    }
  }

  // Response? _validateRequest(Map<String, dynamic> requestData) {
  //   final isDriver = bool.tryParse(
  //         requestData['isDriver'].toString(),
  //       ) ??
  //       false;

  //   final hasCarPlate =
  //       (requestData['carPlate'] as String?)?.isNotEmpty ?? false;

  //   if (isDriver && !hasCarPlate) {
  //     return Response.badRequest(
  //       body: jsonEncode(
  //         {'message': 'Parameter carPlate is required'},
  //       ),
  //     );
  //   }

  //   return null;
  // }
}
