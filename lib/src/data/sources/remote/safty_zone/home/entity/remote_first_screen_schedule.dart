import 'package:json_annotation/json_annotation.dart';
import 'package:safety_zone/src/presentation/screens/installation_options/models/installation_fee_model.dart';

part 'remote_first_screen_schedule.g.dart';

@JsonSerializable()
class RemoteFirstScreenSchedule {
  final String? message;
  final Data? data;

  const RemoteFirstScreenSchedule({
    this.message,
    this.data,
  });

  factory RemoteFirstScreenSchedule.fromJson(Map<String, dynamic> json) =>
      _$RemoteFirstScreenScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteFirstScreenScheduleToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: '_id')
  final String? Id;
  final String? provider;
  final String? consumer;
  final Branch? branch;
  final String? offer;
  final String? responseEmployee;
  final String? requestNumber;
  final String? type;
  final String? status;
  final String? step;
  final int? visitDate;
  final int? createdAt;
  @JsonKey(name: '__v')
  final int? V;
  final ConsumerRequest? consumerRequest;

  const Data({
    this.Id,
    this.provider,
    this.consumer,
    this.branch,
    this.offer,
    this.responseEmployee,
    this.requestNumber,
    this.type,
    this.status,
    this.step,
    this.visitDate,
    this.createdAt,
    this.V,
    this.consumerRequest,
  });

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Branch {
  final Location? location;
  @JsonKey(name: '_id')
  final String? Id;
  final String? branchName;
  final Employee? employee;
  final String? address;

  const Branch({
    this.location,
    this.Id,
    this.branchName,
    this.employee,
    this.address,
  });

  factory Branch.fromJson(Map<String, dynamic> json) =>
      _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}

@JsonSerializable()
class Location {
  final String? type;
  final List<double>? coordinates;

  const Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Employee {
  @JsonKey(name: '_id')
  final String? Id;
  final String? fullName;
  final String? phoneNumber;
  final String? profileImage;
  final String? employeeType;

  const Employee({
    this.Id,
    this.fullName,
    this.phoneNumber,
    this.profileImage,
    this.employeeType,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

@JsonSerializable()
class ConsumerRequest {
  @JsonKey(name: '_id')
  final String? Id;
  final String? requestNumber;
  final List<AlarmItems>? alarmItems;
  final List<AlarmItems>? fireExtinguisherItem;
  final List<FireSystemItem>? fireSystemItem;
  final String? requestType;
  final String? status;

  const ConsumerRequest({
    this.Id,
    this.requestNumber,
    this.alarmItems,
    this.fireExtinguisherItem,
    this.fireSystemItem,
    this.requestType,
    this.status,
  });

  factory ConsumerRequest.fromJson(Map<String, dynamic> json) =>
      _$ConsumerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConsumerRequestToJson(this);
}

@JsonSerializable()
class AlarmItems {
  @JsonKey(name: 'item_id')
  final ItemId? itemId;
  final int? quantity;
  @JsonKey(name: '_id')
  final String? Id;

  const AlarmItems({
    this.itemId,
    this.quantity,
    this.Id,
  });

  factory AlarmItems.fromJson(Map<String, dynamic> json) =>
      _$AlarmItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmItemsToJson(this);
}

@JsonSerializable()
class ItemId {
  @JsonKey(name: '_id')
  final String? Id;
  final ItemName? itemName;
  final String? image;
  final String? type;
  final String? subCategory;

  const ItemId({
    this.Id,
    this.itemName=const ItemName(en: '', ar: ''),
    this.image,
    this.type,
    this.subCategory,
  });

  factory ItemId.fromJson(Map<String, dynamic> json) =>
      _$ItemIdFromJson(json);

  Map<String, dynamic> toJson() => _$ItemIdToJson(this);
}

@JsonSerializable()
class FireSystemItem {
  @JsonKey(name: 'item_id')
  final ItemId? itemId;
  final int? quantity;
  @JsonKey(name: '_id')
  final String? Id;

  const FireSystemItem({
    this.itemId,
    this.quantity,
    this.Id,
  });

  factory FireSystemItem.fromJson(Map<String, dynamic> json) =>
      _$FireSystemItemFromJson(json);

  Map<String, dynamic> toJson() => _$FireSystemItemToJson(this);
}
