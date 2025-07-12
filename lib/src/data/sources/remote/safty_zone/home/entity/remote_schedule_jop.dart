import 'package:json_annotation/json_annotation.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_requests.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';

part 'remote_schedule_jop.g.dart';

@JsonSerializable()
class RemoteScheduleJop {
  @JsonKey(name: '_id')
  final String? Id;
  final String? provider;
  final String? consumer;
  final RemoteBranch? branch;
  final String? offer;
  final RemoteEmployee? responseEmployee;
  final String? requestNumber;
  final String? type;
  final String? status;
  final int? visitDate;
  final int? createdAt;
  @JsonKey(name: '__v')
  final int? V;

  const RemoteScheduleJop({
    this.Id = "",
    this.provider = "",
    this.consumer = "",
    this.branch = const RemoteBranch(),
    this.offer = "",
    this.responseEmployee = const RemoteEmployee(),
    this.requestNumber = "",
    this.type = "",
    this.status = "",
    this.visitDate = 0,
    this.createdAt = 0,
    this.V = 0,
  });

  factory RemoteScheduleJop.fromJson(Map<String, dynamic> json) =>
      _$RemoteScheduleJopFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteScheduleJopToJson(this);
}

extension ScheduleJopMapper on RemoteScheduleJop {
  ScheduleJop mapToScheduleJop() => ScheduleJop(
        Id: Id ?? "",
        provider: provider ?? "",
        consumer: consumer ?? "",
        branch: branch?.mapToDomain() ?? const Branch(),
        offer: offer ?? "",
        responseEmployee: responseEmployee?.mapToDomain() ?? const Employee(),
        requestNumber: requestNumber ?? "",
        type: type ?? "",
        status: status ?? "",
        visitDate: visitDate ?? 0,
        createdAt: createdAt ?? 0,
        V: V ?? 0,
      );
}

extension ScheduleJopListMapper on List<RemoteScheduleJop> {
  List<ScheduleJop> mapToScheduleJop() =>
      map((e) => e.mapToScheduleJop()).toList();
}
