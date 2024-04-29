import 'package:ccca/domain/entity/ride.dart';
import 'package:ccca/infra/repository/account_repository.dart';
import 'package:ccca/infra/repository/ride_repository.dart';

class RequestRide {
  RequestRide({
    required AccountRepository accountRepository,
    required RideRepository rideRepository,
  })  : _accountRepository = accountRepository,
        _rideRepository = rideRepository;

  final AccountRepository _accountRepository;
  final RideRepository _rideRepository;

  Future<RequestRideOutput> execute(RequestRideInput input) async {
    final account = await _accountRepository.getAccountById(
      accountId: input.passengerId,
    );
    if (!(account?.isPassenger ?? false)) {
      throw Exception('Account is not from a passenger');
    }
    final hasActiveRide = await _rideRepository.hasActiveRideByPassengerId(
      passengerId: input.passengerId,
    );
    if (hasActiveRide) {
      throw Exception('Passenger has an active ride');
    }
    final ride = Ride.create(
      input.passengerId,
      input.fromLat,
      input.fromLong,
      input.toLat,
      input.toLong,
    );
    await _rideRepository.saveRide(ride: ride);
    return RequestRideOutput(rideId: ride.rideId);
  }
}

class RequestRideInput {
  RequestRideInput({
    required this.passengerId,
    required this.fromLat,
    required this.fromLong,
    required this.toLat,
    required this.toLong,
  });

  final String passengerId;
  final double fromLat;
  final double fromLong;
  final double toLat;
  final double toLong;
}

class RequestRideOutput {
  RequestRideOutput({
    required this.rideId,
  });

  final String rideId;
}
