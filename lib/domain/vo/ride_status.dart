import 'package:ccca/domain/entity/ride.dart';

abstract class RideStatus {
  // RideStatus(this.value);
  late final String value;

  void request();
  void accept();
  void start();
}

class RequestedStatus implements RideStatus {
  RequestedStatus(this.ride);

  final Ride ride;

  @override
  String value = 'requested';

  @override
  void accept() {
    ride.rideStatus = AcceptedStatus(ride);
  }

  @override
  void request() {
    throw Exception('Invalid status');
  }

  @override
  void start() {
    throw Exception('Invalid status');
  }
}

class AcceptedStatus implements RideStatus {
  AcceptedStatus(this.ride);

  final Ride ride;

  @override
  String value = 'accepted';

  @override
  void accept() {
    throw Exception('Invalid status');
  }

  @override
  void request() {
    throw Exception('Invalid status');
  }

  @override
  void start() {
    ride.rideStatus = InProgressStatus(ride);
  }
}

class InProgressStatus implements RideStatus {
  InProgressStatus(this.ride);

  final Ride ride;

  @override
  String value = 'in_progress';

  @override
  void accept() {
    throw Exception('Invalid status');
  }

  @override
  void request() {
    throw Exception('Invalid status');
  }

  @override
  void start() {
    throw Exception('Invalid status');
  }
}

class RideStatusFactory {
  static RideStatus create(Ride ride, String status) {
    if (status == 'requested') {
      return RequestedStatus(ride);
    }
    if (status == 'accepted') {
      return AcceptedStatus(ride);
    }
    if (status == 'in_progress') {
      return InProgressStatus(ride);
    }
    throw Exception();
  }
}
