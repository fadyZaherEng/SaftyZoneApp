// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_request_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteRequestDetails _$RemoteRequestDetailsFromJson(
        Map<String, dynamic> json) =>
    RemoteRequestDetails(
      result: json['result'] == null
          ? const RemoteResult()
          : RemoteResult.fromJson(json['result'] as Map<String, dynamic>),
      termsAndConditions: json['termsAndConditions'] == null
          ? const RemoteTermsAndConditions()
          : RemoteTermsAndConditions.fromJson(
              json['termsAndConditions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteRequestDetailsToJson(
        RemoteRequestDetails instance) =>
    <String, dynamic>{
      'result': instance.result,
      'termsAndConditions': instance.termsAndConditions,
    };

RemoteResult _$RemoteResultFromJson(Map<String, dynamic> json) => RemoteResult(
      Id: json['_id'] as String? ?? "",
      consumer: json['consumer'] as String? ?? "",
      branch: json['branch'] == null
          ? const RemoteBranch()
          : RemoteBranch.fromJson(json['branch'] as Map<String, dynamic>),
      requestNumber: json['requestNumber'] as String? ?? "",
      systemType: json['systemType'] as String? ?? "",
      space: (json['space'] as num?)?.toInt() ?? 0,
      requestType: json['requestType'] as String? ?? "",
      status: json['status'] as String? ?? "",
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
      alarmItems: (json['alarmItems'] as List<dynamic>?)
              ?.map((e) => RemoteItems.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      fireExtinguisherItem: (json['fireExtinguisherItem'] as List<dynamic>?)
              ?.map((e) => RemoteItems.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      fireSystemItem: (json['fireSystemItem'] as List<dynamic>?)
              ?.map((e) => RemoteItems.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      numberOfVisits: (json['numberOfVisits'] as num?)?.toInt() ?? 0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteResultToJson(RemoteResult instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'consumer': instance.consumer,
      'branch': instance.branch,
      'requestNumber': instance.requestNumber,
      'systemType': instance.systemType,
      'space': instance.space,
      'requestType': instance.requestType,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'alarmItems': instance.alarmItems,
      'fireExtinguisherItem': instance.fireExtinguisherItem,
      'fireSystemItem': instance.fireSystemItem,
      'numberOfVisits': instance.numberOfVisits,
      'duration': instance.duration,
    };

RemoteItems _$RemoteItemsFromJson(Map<String, dynamic> json) => RemoteItems(
      itemId: json['item_id'] == null
          ? const RemoteItemId()
          : RemoteItemId.fromJson(json['item_id'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      id: json['_id'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteItemsToJson(RemoteItems instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'quantity': instance.quantity,
      '_id': instance.id,
    };

RemoteItemId _$RemoteItemIdFromJson(Map<String, dynamic> json) => RemoteItemId(
      Id: json['_id'] as String? ?? "",
      itemName: json['itemName'] == null
          ? const ItemName()
          : ItemName.fromJson(json['itemName'] as Map<String, dynamic>),
      type: json['type'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteItemIdToJson(RemoteItemId instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'itemName': instance.itemName,
      'type': instance.type,
    };

RemoteTermsAndConditions _$RemoteTermsAndConditionsFromJson(
        Map<String, dynamic> json) =>
    RemoteTermsAndConditions(
      Id: json['_id'] as String? ?? "",
      employee: json['employee'] == null
          ? const RemoteEmployee()
          : RemoteEmployee.fromJson(json['employee'] as Map<String, dynamic>),
      company: json['company'] as String? ?? "",
      clauses: (json['clauses'] as List<dynamic>?)
              ?.map((e) => RemoteClauses.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteTermsAndConditionsToJson(
        RemoteTermsAndConditions instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'employee': instance.employee,
      'company': instance.company,
      'clauses': instance.clauses,
      'createdAt': instance.createdAt,
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
