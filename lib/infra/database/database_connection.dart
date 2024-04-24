import 'package:postgres/postgres.dart';

abstract class DatabaseConnection {
  Future<DatabaseConnection> open();
  Future<Result> query(String statement, Object? params);
  Future<void> close();
}

class PgAdapter implements DatabaseConnection {
  late Connection _connection;

  @override
  Future<DatabaseConnection> open() async {
    _connection = await Connection.open(
      Endpoint(
        host: 'localhost',
        database: 'postgres',
        username: 'cccat16',
        password: 'cccat16_password',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );

    return this;
  }

  @override
  Future<Result> query(String statement, Object? params) async {
    return _connection.execute(
      statement,
      parameters: params,
    );
  }

  @override
  Future<void> close() async {
    await _connection.close();
  }
}
