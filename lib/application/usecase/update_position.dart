import 'package:ccca/domain/entity/position.dart';
import 'package:ccca/infra/repository/position_repository.dart';

class UpdatePosition {
  UpdatePosition({
    // required RideRepository rideRepository,
    required PositionRepository positionRepository,
  }) :
        // _rideRepository = rideRepository,
        _positionRepository = positionRepository;

  // final RideRepository _rideRepository;
  final PositionRepository _positionRepository;

  Future<void> execute(UpdatePositionInput input) async {
    final position = Position.create(
      input.rideId,
      input.lat,
      input.long,
    );
    await _positionRepository.savePosition(position);
  }
}

class UpdatePositionInput {
  UpdatePositionInput({
    required this.rideId,
    required this.lat,
    required this.long,
  });

  final String rideId;
  final double lat;
  final double long;
}
