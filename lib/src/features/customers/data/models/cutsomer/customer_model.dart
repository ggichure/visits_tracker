import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Customer;

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel extends Equatable {
  const CustomerModel({this.id, this.name, this.createdAt});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return _$CustomerModelFromJson(json);
  }

  factory CustomerModel.fromEntity(Customer entity) {
    return CustomerModel(
      id: entity.id,
      name: entity.name,
      createdAt: entity.createdAt,
    );
  }

  final int? id;
  final String? name;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  CustomerModel copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, createdAt];

  Customer toEntity() {
    return Customer(
      id: id,
      name: name,
      createdAt: createdAt,
    );
  }
}
