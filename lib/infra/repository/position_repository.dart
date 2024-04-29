import 'dart:developer';

import 'package:ccca/domain/entity/position.dart';
import 'package:ccca/infra/database/database_connection.dart';

abstract class PositionRepository {
  Future<void> savePosition(Position position);
}

class PositionRepositoryDatabase implements PositionRepository {
  PositionRepositoryDatabase({required DatabaseConnection connection})
      : _connection = connection;

  final DatabaseConnection _connection;

  @override
  Future<void> savePosition(Position position) async {
    final conn = await _connection.open();

    try {
      await conn.query(
        r'insert into cccat16.position (position_id, ride_id, lat, long, date) values ($1, $2, $3, $4, $5)',
        [
          position.positionId,
          position.rideId,
          position.coord.getLat(),
          position.coord.getLong(),
          position.date,
        ],
      );
    } on Exception catch (e, s) {
      log(
        'Erro ao salvar posição da corrida',
        error: e,
        stackTrace: s,
      );
      throw Exception('Erro ao salvar posição da corrida');
    } finally {
      await conn.close();
    }
  }
}
