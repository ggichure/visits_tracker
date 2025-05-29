import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit.g.dart';

@JsonSerializable()
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

  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);

  @JsonKey(name: 'activities_done')
  final List<String>? activitiesDone;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'customer_id')
  final int? customerId;
  @JsonKey(name: 'id', includeToJson: false)
  final int? id;
  final String? location;
  final String? notes;
  final String? status;
  @JsonKey(name: 'visit_date')
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

  Map<String, dynamic> toJson() => _$VisitToJson(this);

  Visit copyWith({
    int? id,
    int? customerId,
    String? visitDate,
    String? status,
    String? location,
    String? notes,
    List<String>? activitiesDone,
    String? createdAt,
  }) {
    return Visit(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      visitDate: visitDate ?? this.visitDate,
      status: status ?? this.status,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      activitiesDone: activitiesDone ?? this.activitiesDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
