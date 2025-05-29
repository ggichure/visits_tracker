import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer extends Equatable {
  const Customer({this.id, this.name, this.createdAt});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return _$CustomerFromJson(json);
  }

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  final int? id;
  final String? name;

  @override
  List<Object?> get props => [id, name, createdAt];

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  Customer copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
