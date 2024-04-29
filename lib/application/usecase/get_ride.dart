import 'package:ccca/infra/repository/account_repository.dart';
import 'package:ccca/infra/repository/ride_repository.dart';

class GetRide {
  GetRide({
    required AccountRepository accountRepository,
    required RideRepository rideRepository,
  })  : _accountRepository = accountRepository,
        _rideRepository = rideRepository;

  final AccountRepository _accountRepository;
  final RideRepository _rideRepository;

  Future<GetRideOutput> execute(GetRideInput input) async {
    final ride = await _rideRepository.getRideById(rideId: input.rideId);
    final passenger =
        await _accountRepository.getAccountById(accountId: ride.passengerId);
    return GetRideOutput(
      rideId: ride.rideId,
      passengerId: ride.passengerId,
      fromLat: ride.fromLat,
      fromLong: ride.fromLong,
      toLat: ride.toLat,
      toLong: ride.toLong,
      status: ride.status,
      passengerName: passenger?.name ?? '',
      passengerEmail: passenger?.email ?? '',
    );
  }
}

class GetRideInput {
  GetRideInput({
    required this.rideId,
  });

  final String rideId;
}

class GetRideOutput {
  GetRideOutput({
    required this.rideId,
    required this.passengerId,
    required this.fromLat,
    required this.fromLong,
    required this.toLat,
    required this.toLong,
    required this.status,
    required this.passengerName,
    required this.passengerEmail,
  });

  final String rideId;
  final String passengerId;
  final double fromLat;
  final double fromLong;
  final double toLat;
  final double toLong;
  final String status;
  final String passengerName;
  final String passengerEmail;
}
