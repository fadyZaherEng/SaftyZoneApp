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
  final RemoteConsumer? consumer;
  final String? consumerRequest;
  final RemoteBranch? branch;
  final String? offer;
  final RemoteEmployee? responseEmployee;
  final String? requestNumber;
  final String? type;
  final String? status;
  final String? receiveItem;
  final String? step;
  final int? visitDate;
  final int? numberOfVisits;
  final int? createdAt;
  @JsonKey(name: '__v')
  final int? V;

  const RemoteScheduleJop({
    this.Id = "",
    this.provider = "",
    this.consumer = const RemoteConsumer(),
    this.branch = const RemoteBranch(),
    this.offer = "",
    this.responseEmployee = const RemoteEmployee(),
    this.requestNumber = "",
    this.type = "",
    this.status = "",
    this.visitDate = 0,
    this.createdAt = 0,
    this.V = 0,
    this.step = "",
    this.receiveItem = "",
    this.consumerRequest = "",
    this.numberOfVisits = 0,
  });

  factory RemoteScheduleJop.fromJson(Map<String, dynamic> json) =>
      _$RemoteScheduleJopFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteScheduleJopToJson(this);
}

@JsonSerializable()
class RemoteConsumer {
  @JsonKey(name: '_id')
  final String? id;
  final String? phoneNumber;
  const RemoteConsumer({
    this.id = "",
    this.phoneNumber = "",
  });
  factory RemoteConsumer.fromJson(Map<String, dynamic> json) =>
      _$RemoteConsumerFromJson(json);
  Map<String, dynamic> toJson() => _$RemoteConsumerToJson(this);
}

extension ScheduleJopMapper on RemoteScheduleJop {
  ScheduleJop mapToScheduleJop() => ScheduleJop(
        Id: Id ?? "",
        provider: provider ?? "",
        consumer: consumer ?? const RemoteConsumer(),
        branch: branch?.mapToDomain() ?? const Branch(),
        offer: offer ?? "",
        responseEmployee: responseEmployee?.mapToDomain() ?? const Employee(),
        requestNumber: requestNumber ?? "",
        type: type ?? "",
        status: status ?? "",
        visitDate: visitDate ?? 0,
        createdAt: createdAt ?? 0,
        V: V ?? 0,
        receiveItem: receiveItem ?? "",
        step: step ?? "",
        consumerRequest: consumerRequest ?? "",
        numberOfVisits: numberOfVisits ?? 0,
      );
}

extension ScheduleJopListMapper on List<RemoteScheduleJop> {
  List<ScheduleJop> mapToScheduleJop() =>
      map((e) => e.mapToScheduleJop()).toList();
}

class ScheduleJobResponse {
  final String? message;
  final List<dynamic> data; // أو List<Map<String, dynamic>>
  final Pagination? pagination;

  ScheduleJobResponse({
    this.message,
    required this.data,
    this.pagination,
  });

  factory ScheduleJobResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleJobResponse(
      message: json["message"],
      data: json["data"] ?? [],
      pagination: json["pagination"] != null
          ? Pagination.fromJson(json["pagination"])
          : null,
    );
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json["currentPage"] ?? 1,
      totalPages: json["totalPages"] ?? 0,
      totalItems: json["totalItems"] ?? 0,
      itemsPerPage: json["itemsPerPage"] ?? 10,
    );
  }
}
