// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_term_conditions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteTermConditions _$RemoteTermConditionsFromJson(
        Map<String, dynamic> json) =>
    RemoteTermConditions(
      success: json['success'] as bool? ?? false,
      data: json['data'] == null
          ? const RemoteData()
          : RemoteData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteTermConditionsToJson(
        RemoteTermConditions instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

RemoteData _$RemoteDataFromJson(Map<String, dynamic> json) => RemoteData(
      employee: json['employee'] as String? ?? '',
      company: json['company'] as String? ?? '',
      responsibleEmployeeName: json['responsibleEmployeeName'] as String? ?? '',
      clauses: (json['clauses'] as List<dynamic>?)
              ?.map((e) => RemoteClauses.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
      Id: json['_id'] as String? ?? '',
      V: (json['__v'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteDataToJson(RemoteData instance) =>
    <String, dynamic>{
      'employee': instance.employee,
      'company': instance.company,
      'responsibleEmployeeName': instance.responsibleEmployeeName,
      'clauses': instance.clauses,
      'createdAt': instance.createdAt,
      '_id': instance.Id,
      '__v': instance.V,
    };

RemoteClauses _$RemoteClausesFromJson(Map<String, dynamic> json) =>
    RemoteClauses(
      text: json['text'] as String? ?? '',
      Id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteClausesToJson(RemoteClauses instance) =>
    <String, dynamic>{
      'text': instance.text,
      '_id': instance.Id,
    };
