import 'dart:math' as math;
import 'package:exercicio_aula1/domain/coord.dart';

class Segment {
  Segment({
    required this.from,
    required this.to,
  });

  final Coord to;
  final Coord from;

  double getDistance() {
    const earthRadius = 6371;
    const degreesToRadians = math.pi / 180;
    final deltaLat = (to.getLat() - from.getLat()) * degreesToRadians;
    final deltaLon = (to.getLong() - from.getLong()) * degreesToRadians;
    final a = math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
        math.cos(from.getLat() * degreesToRadians) *
            math.cos(to.getLat() * degreesToRadians) *
            math.sin(deltaLon / 2) *
            math.sin(deltaLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    final distance = earthRadius * c;
    return distance;
  }
}
