import 'dart:math' as math;

import 'package:exercicio_aula1/application/usecase/get_ride.dart';
import 'package:exercicio_aula1/application/usecase/request_ride.dart';
import 'package:exercicio_aula1/application/usecase/signup.dart';
import 'package:exercicio_aula1/infra/database/database_connection.dart';
import 'package:exercicio_aula1/infra/geteway/mailer_gateway.dart';
import 'package:exercicio_aula1/infra/repository/account_repository.dart';
import 'package:exercicio_aula1/infra/repository/ride_repository.dart';
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
    final inputSignup = SignupInput(
      name: 'John Doe',
      email: 'john.doe${math.Random().nextInt(1000)}@gmail.com',
      cpf: '87748248800',
      isPassenger: true,
    );

    final outputSignup = await signup.execute(inputSignup);
    final requestRide = RequestRide(
      accountRepository: accountRepository,
      rideRepository: rideRepository,
    );
    final inputRequestRide = RequestRideInput(
      passengerId: outputSignup.accountId,
      fromLat: -27.584905257808835,
      fromLong: -48.545022195325124,
      toLat: -27.496887588317275,
      toLong: -48.522234807851476,
    );
    final outputRequestRide = await requestRide.execute(inputRequestRide);
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
    expect(outputGetRide.fromLat, inputRequestRide.fromLat);
    expect(outputGetRide.fromLong, inputRequestRide.fromLong);
    expect(outputGetRide.toLat, inputRequestRide.toLat);
    expect(outputGetRide.toLong, inputRequestRide.toLong);
    expect(outputGetRide.passengerName, 'John Doe');
    expect(
      outputGetRide.passengerEmail,
      inputSignup.email,
    );
    await connection.close();
  });
}
