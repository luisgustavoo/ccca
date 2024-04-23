import 'package:postgres/postgres.dart';

class DatabaseConnection {
  late Connection _connection;

  Future<Connection> get instance async {
    return _connection = await Connection.open(
      Endpoint(
        host: 'localhost',
        database: 'postgres',
        username: 'cccat16',
        password: 'cccat16_password',
      ),
    );
  }

  Future<void> close() async {
    return _connection.close();
  }
}
