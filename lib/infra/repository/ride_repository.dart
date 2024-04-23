import 'dart:developer';

import 'package:exercicio_aula1/domain/ride.dart';
import 'package:exercicio_aula1/infra/database/database_connection.dart';

abstract class RideRepository {
  Future<void> saveRide({required Ride ride});
  Future<bool> hasActiveRideByPassengerId({required String passengerId});
  Future<Ride> getRideById({required String rideId});
}

class RideRepositoryDatabase implements RideRepository {
  RideRepositoryDatabase({required DatabaseConnection connection})
      : _connection = connection;

  final DatabaseConnection _connection;
  @override
  Future<Ride> getRideById({required String rideId}) async {
    final conn = await _connection.instance;

    try {
      final rideData = await conn.execute(
        r'select * from cccat16.ride where ride_id = $1',
        parameters: [rideId],
      );

      final row = rideData.first.toColumnMap();

      return Ride.restore(
        row['ride_id'].toString(),
        row['passenger_id'].toString(),
        double.parse(row['from_lat'].toString()),
        double.parse(row['from_long'].toString()),
        double.parse(row['to_lat'].toString()),
        double.parse(row['to_long'].toString()),
        row['status'].toString(),
        DateTime.parse(row['date'].toString()),
      );
    } on Exception catch (e, s) {
      log(
        'Erro a buscar usuário pelo id',
        error: e,
        stackTrace: s,
      );
      throw Exception('Erro a buscar usuário pelo id');
    } finally {
      await conn.close();
    }
  }

  @override
  Future<bool> hasActiveRideByPassengerId({required String passengerId}) async {
    final conn = await _connection.instance;

    try {
      final rideData = await conn.execute(
        r'select * from cccat16.ride where passenger_id = $1 and status <> '
        'completed'
        ' ',
        parameters: [passengerId],
      );

      return rideData.affectedRows >= 1;
    } on Exception catch (e, s) {
      log(
        'Erro ao verificar corrida ativa',
        error: e,
        stackTrace: s,
      );
      throw Exception('Erro ao verificar corrida ativa');
    } finally {
      await conn.close();
    }
  }

  @override
  Future<void> saveRide({required Ride ride}) async {
    final conn = await _connection.instance;

    try {
      await conn.execute(
        r'insert into cccat16.ride (ride_id, passenger_id, from_lat, from_long, to_lat, to_long, status, date) values ($1, $2, $3, $4, $5, $6, $7, $8)',
        parameters: [
          ride.rideId,
          ride.passengerId,
          ride.fromLat,
          ride.fromLong,
          ride.toLat,
          ride.toLong,
          ride.status,
          ride.date,
        ],
      );
    } on Exception catch (e, s) {
      log(
        'Erro ao registrar corrida',
        error: e,
        stackTrace: s,
      );
      throw Exception('Erro ao registrar corrida');
    } finally {
      await conn.close();
    }
  }
}
