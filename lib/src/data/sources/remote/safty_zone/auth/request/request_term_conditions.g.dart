// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_term_conditions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestTermConditions _$RequestTermConditionsFromJson(
        Map<String, dynamic> json) =>
    RequestTermConditions(
      employee: json['employee'] as String?,
      responsibleEmployeeName: json['responsibleEmployeeName'] as String?,
      clauses: (json['clauses'] as List<dynamic>?)
          ?.map((e) => Clauses.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFirstTime: json['isFirstTime'] as bool?,
    );

Map<String, dynamic> _$RequestTermConditionsToJson(
        RequestTermConditions instance) =>
    <String, dynamic>{
      'employee': instance.employee,
      'responsibleEmployeeName': instance.responsibleEmployeeName,
      'clauses': instance.clauses,
      'isFirstTime': instance.isFirstTime,
    };

Clauses _$ClausesFromJson(Map<String, dynamic> json) => Clauses(
      text: json['text'] as String?,
    );

Map<String, dynamic> _$ClausesToJson(Clauses instance) => <String, dynamic>{
      'text': instance.text,
    };
