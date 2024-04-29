import 'package:ccca/domain/entity/position.dart';
import 'package:ccca/domain/vo/segment.dart';

class DistanceCalculator {
  double calculate(List<Position> positions) {
    var distance = 0.0;
    for (var index = 0; index < positions.length - 1; index++) {
      final position = positions[index];
      if (index + 1 == positions.length) {
        break;
      }
      final nextPosition = positions[index + 1];
      final segment = Segment(from: position.coord, to: nextPosition.coord);
      distance += segment.getDistance();
    }
    return distance;
  }
}
