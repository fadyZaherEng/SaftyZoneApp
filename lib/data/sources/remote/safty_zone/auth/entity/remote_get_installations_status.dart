import 'package:hatif_mobile/domain/entities/auth/get_installations_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_get_installations_status.g.dart';

@JsonSerializable()
class RemoteGetInstallationsStatus {
  final bool? alarmItemCompleted;
  final bool? fireSystemItemCompleted;
  final bool? allCompleted;
  final List<dynamic>? remainingAlarmSubCategories;
  final List<String>? remainingFireSystemSubCategories;

  const RemoteGetInstallationsStatus({
    this.alarmItemCompleted = false,
    this.fireSystemItemCompleted = false,
    this.allCompleted = false,
    this.remainingAlarmSubCategories = const [],
    this.remainingFireSystemSubCategories = const [],
  });

  factory RemoteGetInstallationsStatus.fromJson(Map<String, dynamic> json) =>
      _$RemoteGetInstallationsStatusFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteGetInstallationsStatusToJson(this);
}

extension RemoteGetInstallationsStatusExtension
    on RemoteGetInstallationsStatus {
  GetInstallationsStatus toDomain() => GetInstallationsStatus(
        alarmItemCompleted: alarmItemCompleted ?? false,
        fireSystemItemCompleted: fireSystemItemCompleted ?? false,
        allCompleted: allCompleted ?? false,
        remainingAlarmSubCategories: remainingAlarmSubCategories ?? [],
        remainingFireSystemSubCategories:
            remainingFireSystemSubCategories ?? [],
      );
}
