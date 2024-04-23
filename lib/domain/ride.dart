import 'package:uuid/uuid.dart';

class Ride {
  Ride({
    required this.rideId,
    required this.passengerId,
    required this.fromLat,
    required this.fromLong,
    required this.toLat,
    required this.toLong,
    required this.status,
    required this.date,
  });

  factory Ride.create(
    String passengerId,
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
    String status,
    DateTime date,
  ) {
    return Ride(
      rideId: const Uuid().v1(),
      passengerId: passengerId,
      fromLat: fromLat,
      fromLong: fromLong,
      toLat: toLat,
      toLong: toLong,
      status: status,
      date: date,
    );
  }

  factory Ride.restore(
    String rideId,
    String passengerId,
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
    String status,
    DateTime date,
  ) {
    return Ride(
      rideId: rideId,
      passengerId: passengerId,
      fromLat: fromLat,
      fromLong: fromLong,
      toLat: toLat,
      toLong: toLong,
      status: status,
      date: date,
    );
  }

  final String rideId;
  final String passengerId;
  final double fromLat;
  final double fromLong;
  final double toLat;
  final double toLong;
  final String status;
  final DateTime date;
}
