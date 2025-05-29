import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Activity;

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel extends Equatable {
  const ActivityModel({this.id, this.description, this.createdAt});

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return _$ActivityModelFromJson(json);
  }

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  final String? description;
  final int? id;

  @override
  List<Object?> get props => [id, description, createdAt];

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);

  ActivityModel copyWith({
    int? id,
    String? description,
    DateTime? createdAt,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Activity toEntity() {
    return Activity(
      id: id,
      description: description,
      createdAt: createdAt,
    );
  }

  static ActivityModel fromEntity(Activity entity) {
    return ActivityModel(
      id: entity.id,
      description: entity.description,
      createdAt: entity.createdAt,
    );
  }
}
