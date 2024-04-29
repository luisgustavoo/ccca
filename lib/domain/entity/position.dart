import 'package:ccca/domain/vo/coord.dart';
import 'package:uuid/uuid.dart';

class Position {
  Position({
    required this.positionId,
    required this.rideId,
    required this.coord,
    required this.date,
  });

  factory Position.create(
    String rideId,
    double lat,
    double long,
  ) {
    return Position(
      positionId: const Uuid().v1(),
      rideId: rideId,
      coord: Coord(lat, long),
      date: DateTime.now(),
    );
  }

  factory Position.restore(
    String positionId,
    String rideId,
    double lat,
    double long,
    DateTime date,
  ) {
    return Position(
      positionId: positionId,
      rideId: rideId,
      coord: Coord(lat, long),
      date: date,
    );
  }

  final String positionId;
  final String rideId;
  final Coord coord;
  final DateTime date;
}
