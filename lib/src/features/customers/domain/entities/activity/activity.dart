import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  const Activity({this.id, this.description, this.createdAt});

  final DateTime? createdAt;

  final String? description;
  final int? id;

  @override
  List<Object?> get props => [id, description, createdAt];
}
