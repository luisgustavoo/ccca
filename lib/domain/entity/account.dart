import 'package:uuid/uuid.dart';

class Account {
  Account({
    required this.accountId,
    required this.name,
    required this.email,
    required this.cpf,
    required this.isPassenger,
    required this.isDriver,
    this.carPlate,
  }) {
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      throw Exception('Invalid name');
    }
  }

  factory Account.create(
    String name,
    String email,
    String cpf,
    String? carPlate, {
    bool isPassenger = false,
    bool isDriver = false,
  }) {
    return Account(
      accountId: const Uuid().v1(),
      name: name,
      email: email,
      cpf: cpf,
      carPlate: carPlate ?? '',
      isPassenger: isPassenger,
      isDriver: isDriver,
    );
  }

  factory Account.restore(
    String accountId,
    String name,
    String email,
    String cpf,
    String carPlate, {
    bool isPassenger = false,
    bool isDriver = false,
  }) {
    return Account(
      accountId: accountId,
      name: name,
      email: email,
      cpf: cpf,
      carPlate: carPlate,
      isPassenger: isPassenger,
      isDriver: isDriver,
    );
  }

  final String accountId;
  final String name;
  final String email;
  final String cpf;
  final String? carPlate;
  final bool isPassenger;
  final bool isDriver;
}
