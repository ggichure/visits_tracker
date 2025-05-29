import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  const Customer({this.id, this.name, this.createdAt});

  final DateTime? createdAt;

  final int? id;
  final String? name;

  @override
  List<Object?> get props => [id, name, createdAt];
}
