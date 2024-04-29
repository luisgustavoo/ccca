import 'package:ccca/domain/vo/ride_status.dart';
import 'package:ccca/domain/vo/segment.dart';
import 'package:uuid/uuid.dart';

class Ride {
  Ride({
    required this.rideId,
    required this.passengerId,
    required this.fromLat,
    required this.fromLong,
    required this.toLat,
    required this.toLong,
    required this.date,
    required this.status,
    this.driverId,
  }) {
    rideStatus = RideStatusFactory.create(this, status);
  }

  factory Ride.create(
    String passengerId,
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
  ) {
    return Ride(
      rideId: const Uuid().v1(),
      passengerId: passengerId,
      fromLat: fromLat,
      fromLong: fromLong,
      toLat: toLat,
      toLong: toLong,
      date: DateTime.now(),
      status: 'requested',
    );
  }

  factory Ride.restore(
    String rideId,
    String passengerId,
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
    DateTime date,
    String status,
  ) {
    return Ride(
      rideId: rideId,
      passengerId: passengerId,
      fromLat: fromLat,
      fromLong: fromLong,
      toLat: toLat,
      toLong: toLong,
      date: date,
      status: status,
    );
  }

  final String rideId;
  final String passengerId;
  final double fromLat;
  final double fromLong;
  final double toLat;
  final double toLong;
  final DateTime date;
  final String status;
  late RideStatus rideStatus;
  String? driverId;
  Segment? segment;

  void accept(String driverId) {
    rideStatus.accept();
    this.driverId = driverId;
  }

  void start() {
    rideStatus.start();
  }

  double getFromLat() {
    return segment?.from.getLat() ?? 0;
  }

  double getFromLong() {
    return segment?.from.getLong() ?? 0;
  }

  double getToLag() {
    return segment?.to.getLat() ?? 0;
  }

  double getToLong() {
    return segment?.to.getLong() ?? 0;
  }

  String getStatus() {
    return rideStatus.value;
  }
}
