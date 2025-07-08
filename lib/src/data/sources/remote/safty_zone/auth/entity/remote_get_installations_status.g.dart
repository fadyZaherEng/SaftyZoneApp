// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_get_installations_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteGetInstallationsStatus _$RemoteGetInstallationsStatusFromJson(
        Map<String, dynamic> json) =>
    RemoteGetInstallationsStatus(
      alarmItemCompleted: json['alarmItemCompleted'] as bool? ?? false,
      fireSystemItemCompleted:
          json['fireSystemItemCompleted'] as bool? ?? false,
      allCompleted: json['allCompleted'] as bool? ?? false,
      remainingAlarmSubCategories:
          json['remainingAlarmSubCategories'] as List<dynamic>? ?? const [],
      remainingFireSystemSubCategories:
          (json['remainingFireSystemSubCategories'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const [],
    );

Map<String, dynamic> _$RemoteGetInstallationsStatusToJson(
        RemoteGetInstallationsStatus instance) =>
    <String, dynamic>{
      'alarmItemCompleted': instance.alarmItemCompleted,
      'fireSystemItemCompleted': instance.fireSystemItemCompleted,
      'allCompleted': instance.allCompleted,
      'remainingAlarmSubCategories': instance.remainingAlarmSubCategories,
      'remainingFireSystemSubCategories':
          instance.remainingFireSystemSubCategories,
    };
