import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity extends Equatable {
  const Activity({this.id, this.description, this.createdAt});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return _$ActivityFromJson(json);
  }

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  final String? description;
  final int? id;

  @override
  List<Object?> get props => [id, description, createdAt];

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  Activity copyWith({
    int? id,
    String? description,
    DateTime? createdAt,
  }) {
    return Activity(
      id: id ?? this.id,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
