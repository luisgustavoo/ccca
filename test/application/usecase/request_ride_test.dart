import 'dart:math' as math;

import 'package:ccca/application/usecase/get_ride.dart';
import 'package:ccca/application/usecase/request_ride.dart';
import 'package:ccca/application/usecase/signup.dart';
import 'package:ccca/infra/database/database_connection.dart';
import 'package:ccca/infra/gateway/mailer_gateway.dart';
import 'package:ccca/infra/repository/account_repository.dart';
import 'package:ccca/infra/repository/ride_repository.dart';
import 'package:test/test.dart';

void main() {
  test('Deve solicitar uma corrida', () async {
    final connection = PgAdapter();
    final accountRepository = AccountRepositoryDatabase(connection: connection);
    final rideRepository = RideRepositoryDatabase(connection: connection);
    final mailerGateway = MailerGatewayMemory();
    final signup = Signup(
      accountRepository: accountRepository,
      mailerGateway: mailerGateway,
    );
    final signupInput = SignupInput(
      name: 'John Doe',
      email: 'john.doe${math.Random().nextInt(1000)}@gmail.com',
      cpf: '87748248800',
      isPassenger: true,
    );
    final outputSignup = await signup.execute(signupInput);
    final requestRide = RequestRide(
      accountRepository: accountRepository,
      rideRepository: rideRepository,
    );
    final requestRideInput = RequestRideInput(
      passengerId: outputSignup.accountId,
      fromLat: -27.584905257808835,
      fromLong: -48.545022195325124,
      toLat: -27.496887588317275,
      toLong: -48.522234807851476,
    );
    final outputRequestRide = await requestRide.execute(requestRideInput);
    expect(outputRequestRide.rideId, isNotNull);
    final getRide = GetRide(
      accountRepository: accountRepository,
      rideRepository: rideRepository,
    );
    final inputGetRide = GetRideInput(rideId: outputRequestRide.rideId);
    final outputGetRide = await getRide.execute(inputGetRide);
    expect(outputGetRide.rideId, outputRequestRide.rideId);
    expect(outputGetRide.status, 'requested');
    expect(outputGetRide.passengerId, outputSignup.accountId);
    expect(outputGetRide.fromLat, requestRideInput.fromLat);
    expect(outputGetRide.fromLong, requestRideInput.fromLong);
    expect(outputGetRide.toLat, requestRideInput.toLat);
    expect(outputGetRide.toLong, requestRideInput.toLong);
    expect(outputGetRide.passengerName, 'John Doe');
    expect(outputGetRide.passengerEmail, signupInput.email);
    await connection.close();
  });

  test('Não deve poder solicitar uma corrida se não for um passageiro',
      () async {
    final connection = PgAdapter();
    final accountRepository = AccountRepositoryDatabase(connection: connection);
    final rideRepository = RideRepositoryDatabase(connection: connection);
    final mailerGateway = MailerGatewayMemory();
    final signup = Signup(
      accountRepository: accountRepository,
      mailerGateway: mailerGateway,
    );
    final signupInput = SignupInput(
      name: 'John Doe',
      email: 'john.doe${math.Random().nextInt(1000)}@gmail.com',
      cpf: '87748248800',
      isDriver: true,
    );
    final outputSignup = await signup.execute(signupInput);
    final requestRide = RequestRide(
      accountRepository: accountRepository,
      rideRepository: rideRepository,
    );
    final requestRideInput = RequestRideInput(
      passengerId: outputSignup.accountId,
      fromLat: -27.584905257808835,
      fromLong: -48.545022195325124,
      toLat: -27.496887588317275,
      toLong: -48.522234807851476,
    );
    final callRequestRide = requestRide;

    expect(
      callRequestRide.execute(requestRideInput),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString().replaceAll('Exception: ', ''),
          'message',
          'Account is not from a passenger',
        ),
      ),
    );

    await connection.close();
  });

  test(
      'Não deve poder solicitar uma corrida se o passageiro já tiver outra corrida ativa',
      () async {
    final connection = PgAdapter();
    final accountRepository = AccountRepositoryDatabase(connection: connection);
    final rideRepository = RideRepositoryDatabase(connection: connection);
    final mailerGateway = MailerGatewayMemory();
    final signup = Signup(
      accountRepository: accountRepository,
      mailerGateway: mailerGateway,
    );
    final signupInput = SignupInput(
      name: 'John Doe',
      email: 'john.doe${math.Random().nextInt(1000)}@gmail.com',
      cpf: '87748248800',
      isPassenger: true,
    );
    final outputSignup = await signup.execute(signupInput);
    final requestRide = RequestRide(
      accountRepository: accountRepository,
      rideRepository: rideRepository,
    );
    final requestRideInput = RequestRideInput(
      passengerId: outputSignup.accountId,
      fromLat: -27.584905257808835,
      fromLong: -48.545022195325124,
      toLat: -27.496887588317275,
      toLong: -48.522234807851476,
    );

    await requestRide.execute(requestRideInput);

    final callRequestRide = requestRide;

    expect(
      callRequestRide.execute(requestRideInput),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString().replaceAll('Exception: ', ''),
          'message',
          'Passenger has an active ride',
        ),
      ),
    );

    await connection.close();
  });
}
