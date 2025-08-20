// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_schedule_jop_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteScheduleJopDetails _$RemoteScheduleJopDetailsFromJson(
        Map<String, dynamic> json) =>
    RemoteScheduleJopDetails(
      Id: json['_id'] as String?,
      provider: json['provider'] as String?,
      consumer: json['consumer'] as String?,
      consumerRequest: json['consumerRequest'] == null
          ? null
          : ConsumerRequest.fromJson(
              json['consumerRequest'] as Map<String, dynamic>),
      branch: json['branch'] == null
          ? null
          : Branch.fromJson(json['branch'] as Map<String, dynamic>),
      offer: json['offer'] as String?,
      responseEmployee: json['responseEmployee'] as String?,
      receiveItem: json['receiveItem'],
      requestNumber: json['requestNumber'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      step: json['step'] as String?,
      visitDate: (json['visitDate'] as num?)?.toInt(),
      numberOfVisits: (json['numberOfVisits'] as num?)?.toInt(),
      createdAt: (json['createdAt'] as num?)?.toInt(),
      V: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RemoteScheduleJopDetailsToJson(
        RemoteScheduleJopDetails instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'provider': instance.provider,
      'consumer': instance.consumer,
      'consumerRequest': instance.consumerRequest,
      'branch': instance.branch,
      'offer': instance.offer,
      'responseEmployee': instance.responseEmployee,
      'receiveItem': instance.receiveItem,
      'requestNumber': instance.requestNumber,
      'type': instance.type,
      'status': instance.status,
      'step': instance.step,
      'visitDate': instance.visitDate,
      'numberOfVisits': instance.numberOfVisits,
      'createdAt': instance.createdAt,
      '__v': instance.V,
    };

ConsumerRequest _$ConsumerRequestFromJson(Map<String, dynamic> json) =>
    ConsumerRequest(
      Id: json['_id'] as String?,
      requestNumber: json['requestNumber'] as String?,
      systemType: json['systemType'] as String?,
      space: (json['space'] as num?)?.toInt(),
      alarmItems: (json['alarmItems'] as List<dynamic>?)
          ?.map((e) => AlarmItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      fireExtinguisherItem: (json['fireExtinguisherItem'] as List<dynamic>?)
          ?.map((e) => AlarmItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      fireSystemItem: (json['fireSystemItem'] as List<dynamic>?)
          ?.map((e) => AlarmItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestType: json['requestType'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ConsumerRequestToJson(ConsumerRequest instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'requestNumber': instance.requestNumber,
      'systemType': instance.systemType,
      'space': instance.space,
      'alarmItems': instance.alarmItems,
      'fireExtinguisherItem': instance.fireExtinguisherItem,
      'fireSystemItem': instance.fireSystemItem,
      'requestType': instance.requestType,
      'status': instance.status,
    };

AlarmItems _$AlarmItemsFromJson(Map<String, dynamic> json) => AlarmItems(
      itemId: json['item_id'] == null
          ? null
          : ItemId.fromJson(json['item_id'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt(),
      Id: json['_id'] as String?,
    );

Map<String, dynamic> _$AlarmItemsToJson(AlarmItems instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'quantity': instance.quantity,
      '_id': instance.Id,
    };

ItemId _$ItemIdFromJson(Map<String, dynamic> json) => ItemId(
      Id: json['_id'] as String?,
      itemName: json['itemName'] == null
          ? null
          : ItemName.fromJson(json['itemName'] as Map<String, dynamic>),
      image: json['image'] as String?,
      type: json['type'] as String?,
      subCategory: json['subCategory'] as String?,
    );

Map<String, dynamic> _$ItemIdToJson(ItemId instance) => <String, dynamic>{
      '_id': instance.Id,
      'itemName': instance.itemName,
      'image': instance.image,
      'type': instance.type,
      'subCategory': instance.subCategory,
    };

ItemName _$ItemNameFromJson(Map<String, dynamic> json) => ItemName(
      en: json['en'] as String?,
      ar: json['ar'] as String?,
    );

Map<String, dynamic> _$ItemNameToJson(ItemName instance) => <String, dynamic>{
      'en': instance.en,
      'ar': instance.ar,
    };

FireSystemItem _$FireSystemItemFromJson(Map<String, dynamic> json) =>
    FireSystemItem(
      itemId: json['item_id'] == null
          ? null
          : ItemId.fromJson(json['item_id'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt(),
      Id: json['_id'] as String?,
    );

Map<String, dynamic> _$FireSystemItemToJson(FireSystemItem instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'quantity': instance.quantity,
      '_id': instance.Id,
    };

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      Id: json['_id'] as String?,
      branchName: json['branchName'] as String?,
      employee: json['employee'] == null
          ? null
          : Employee.fromJson(json['employee'] as Map<String, dynamic>),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'location': instance.location,
      '_id': instance.Id,
      'branchName': instance.branchName,
      'employee': instance.employee,
      'address': instance.address,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      Id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profileImage: json['profileImage'] as String?,
      employeeType: json['employeeType'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      '_id': instance.Id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'profileImage': instance.profileImage,
      'employeeType': instance.employeeType,
    };
