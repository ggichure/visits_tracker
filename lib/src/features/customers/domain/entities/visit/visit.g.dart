// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visit _$VisitFromJson(Map<String, dynamic> json) => Visit(
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

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'activities_done': instance.activitiesDone,
      'created_at': instance.createdAt,
      'customer_id': instance.customerId,
      'location': instance.location,
      'notes': instance.notes,
      'status': instance.status,
      'visit_date': instance.visitDate,
    };
