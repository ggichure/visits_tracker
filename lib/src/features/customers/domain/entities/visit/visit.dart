import 'package:equatable/equatable.dart';

class Visit extends Equatable {
  const Visit({
    this.id,
    this.customerId,
    this.visitDate,
    this.status,
    this.location,
    this.notes,
    this.activitiesDone,
    this.createdAt,
  });

  final List<String>? activitiesDone;

  final String? createdAt;

  final int? customerId;

  final int? id;
  final String? location;
  final String? notes;
  final String? status;

  final String? visitDate;

  @override
  List<Object?> get props {
    return [
      id,
      customerId,
      visitDate,
      status,
      location,
      notes,
      activitiesDone,
      createdAt,
    ];
  }
}
