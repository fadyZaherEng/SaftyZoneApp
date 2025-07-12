import 'package:json_annotation/json_annotation.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_requests.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';

part 'remote_request_details.g.dart';

@JsonSerializable()
class RemoteRequestDetails {
  final RemoteResult? result;
  final RemoteTermsAndConditions? termsAndConditions;

  const RemoteRequestDetails({
    this.result = const RemoteResult(),
    this.termsAndConditions = const RemoteTermsAndConditions(),
  });

  factory RemoteRequestDetails.fromJson(Map<String, dynamic> json) =>
      _$RemoteRequestDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteRequestDetailsToJson(this);
}

extension RemoteRequestDetailsExtension on RemoteRequestDetails {
  RequestDetails mapToDomain() {
    return RequestDetails(
      result: result?.mapToDomain() ?? const Result(),
      termsAndConditions:
          termsAndConditions?.mapToDomain() ?? const TermsAndConditions(),
    );
  }
}

@JsonSerializable()
class RemoteResult {
  @JsonKey(name: '_id')
  final String? Id;
  final String? consumer;
  final RemoteBranch? branch;
  final String? requestNumber;
  final String? systemType;
  final int? space;
  final List<RemoteItems>? items;
  final String? requestType;
  final String? status;
  final int? createdAt;

  const RemoteResult({
    this.Id = "",
    this.consumer = "",
    this.branch = const RemoteBranch(),
    this.requestNumber = "",
    this.systemType = "",
    this.space = 0,
    this.items = const [],
    this.requestType = "",
    this.status = "",
    this.createdAt = 0,
  });

  factory RemoteResult.fromJson(Map<String, dynamic> json) =>
      _$RemoteResultFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteResultToJson(this);
}

extension RemoteResultExtension on RemoteResult {
  Result mapToDomain() {
    return Result(
      Id: Id ?? "",
      consumer: consumer ?? "",
      branch: branch?.mapToDomain() ?? const Branch(),
      requestNumber: requestNumber ?? "",
      systemType: systemType ?? "",
      space: space ?? 0,
      items: items?.mapToDomain() ?? const [],
      requestType: requestType ?? "",
      status: status ?? "",
      createdAt: createdAt ?? 0,
    );
  }
}

@JsonSerializable()
class RemoteItems {
  @JsonKey(name: 'item_id')
  final RemoteItemId? itemId;
  final int? quantity;
  @JsonKey(name: '_id')
  final String? Id;

  const RemoteItems({
    this.itemId = const RemoteItemId(),
    this.quantity = 0,
    this.Id = "",
  });

  factory RemoteItems.fromJson(Map<String, dynamic> json) =>
      _$RemoteItemsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteItemsToJson(this);
}
extension RemoteItemsExtension on RemoteItems {
  Items mapToDomain() {
    return Items(
      itemId: itemId?.mapToDomain() ?? const ItemId(),
      quantity: quantity ?? 0,
      Id: Id ?? "",
    );
  }
}
extension RemoteItemsListExtension on List<RemoteItems> {
  List<Items> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}

@JsonSerializable()
class RemoteItemId {
  @JsonKey(name: '_id')
  final String? Id;
  final String? itemName;
  final String? type;

  const RemoteItemId({
    this.Id = "",
    this.itemName = "",
    this.type = "",
  });

  factory RemoteItemId.fromJson(Map<String, dynamic> json) =>
      _$RemoteItemIdFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteItemIdToJson(this);
}

extension RemoteItemIdExtension on RemoteItemId {
  ItemId mapToDomain() {
    return ItemId(
      Id: Id ?? "",
      itemName: itemName ?? "",
      type: type ?? "",
    );
  }
}

extension RemoteItemIdListExtension on List<RemoteItemId> {
  List<ItemId> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}

@JsonSerializable()
class RemoteTermsAndConditions {
  @JsonKey(name: '_id')
  final String? Id;
  final RemoteEmployee? employee;
  final String? company;
  final List<RemoteClauses>? clauses;
  final int? createdAt;

  const RemoteTermsAndConditions({
    this.Id = "",
    this.employee = const RemoteEmployee(),
    this.company = "",
    this.clauses = const [],
    this.createdAt = 0,
  });

  factory RemoteTermsAndConditions.fromJson(Map<String, dynamic> json) =>
      _$RemoteTermsAndConditionsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteTermsAndConditionsToJson(this);
}

extension TermsAndConditionsExtension on RemoteTermsAndConditions {
  TermsAndConditions mapToDomain() {
    return TermsAndConditions(
      Id: Id ?? "",
      employee: employee?.mapToDomain() ?? const Employee(),
      company: company ?? "",
      clauses: clauses?.map((e) => e.mapToDomain()).toList() ?? const [],
    );
  }
}
extension TermsAndConditionsListExtension on List<RemoteTermsAndConditions> {
  List<TermsAndConditions> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}

@JsonSerializable()
class RemoteClauses {
  final String? text;
  @JsonKey(name: '_id')
  final String? Id;

  const RemoteClauses({
    this.text = '',
    this.Id = '',
  });

  factory RemoteClauses.fromJson(Map<String, dynamic> json) =>
      _$RemoteClausesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteClausesToJson(this);
}

extension RemoteClauseExtension on RemoteClauses {
  Clauses mapToDomain() {
    return Clauses(
      text: text ?? "",
      Id: Id ?? "",
    );
  }
}
extension RemoteClauseListExtension on List<RemoteClauses> {
  List<Clauses> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}
