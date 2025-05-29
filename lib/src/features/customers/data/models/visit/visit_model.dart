import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Visit;

part 'visit_model.g.dart';

@JsonSerializable()
class VisitModel extends Equatable {
  const VisitModel({
    this.id,
    this.customerId,
    this.visitDate,
    this.status,
    this.location,
    this.notes,
    this.activitiesDone,
    this.createdAt,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return _$VisitModelFromJson(json);
  }

  factory VisitModel.fromEntity(Visit visit) {
    return VisitModel(
      id: visit.id,
      customerId: visit.customerId,
      visitDate: visit.visitDate,
      status: visit.status,
      location: visit.location,
      notes: visit.notes,
      activitiesDone: visit.activitiesDone,
      createdAt: visit.createdAt,
    );
  }
  @JsonKey(name: 'id', includeToJson: false)
  final int? id;
  @JsonKey(name: 'customer_id')
  final int? customerId;
  @JsonKey(name: 'visit_date')
  final String? visitDate;
  final String? status;
  final String? location;
  final String? notes;
  @JsonKey(name: 'activities_done')
  final List<String>? activitiesDone;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  Map<String, dynamic> toJson() => _$VisitModelToJson(this);

  VisitModel copyWith({
    int? id,
    int? customerId,
    String? visitDate,
    String? status,
    String? location,
    String? notes,
    List<String>? activitiesDone,
    String? createdAt,
  }) {
    return VisitModel(
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
  Visit toEntity() {
    return Visit(
      id: id,
      customerId: customerId,
      visitDate: visitDate,
      status: status,
      location: location,
      notes: notes,
      activitiesDone: activitiesDone,
      createdAt: createdAt,
    );
  }
}
