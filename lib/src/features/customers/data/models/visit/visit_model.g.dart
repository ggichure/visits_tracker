// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitModel _$VisitModelFromJson(Map<String, dynamic> json) => VisitModel(
      id: (json['id'] as num?)?.toInt(),
      customerId: (json['customer_id'] as num?)?.toInt(),
      visitDate: json['visit_date'] as String?,
      status: json['status'] as String?,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      activitiesDone: (json['activities_done'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$VisitModelToJson(VisitModel instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'visit_date': instance.visitDate,
      'status': instance.status,
      'location': instance.location,
      'notes': instance.notes,
      'activities_done': instance.activitiesDone,
      'created_at': instance.createdAt,
    };
