import 'dart:convert';

class AccountModel {
  AccountModel({
    required this.accountId,
    required this.name,
    required this.email,
    required this.cpf,
    required this.carPlate,
    required this.isPassenger,
    required this.isDriver,
  });

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountId: map['account_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      cpf: map['cpf'] as String,
      carPlate: map['car_plate'] as String,
      isPassenger: map['is_passenger'] as bool,
      isDriver: map['is_driver'] as bool,
    );
  }

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final String accountId;
  final String name;
  final String email;
  final String cpf;
  final String carPlate;
  final bool isPassenger;
  final bool isDriver;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'account_id': accountId,
      'name': name,
      'email': email,
      'cpf': cpf,
      'car_plate': carPlate,
      'is_passenger': isPassenger,
      'is_driver': isDriver,
    };
  }

  String toJson() => json.encode(toMap());
}
