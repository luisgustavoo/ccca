import 'package:exercicio_aula1/infra/repository/ride_repository.dart';

class StartRide {
  StartRide({
    required RideRepository rideRepository,
  }) : _rideRepository = rideRepository;
  final RideRepository _rideRepository;
  Future<void> execute(StartRideInput input) async {
    final ride = await _rideRepository.getRideById(
      rideId: input.rideId,
    );
    ride.start();
    await _rideRepository.updateRide(ride: ride);
  }
}

class StartRideInput {
  StartRideInput({
    required this.rideId,
  });

  final String rideId;
}
