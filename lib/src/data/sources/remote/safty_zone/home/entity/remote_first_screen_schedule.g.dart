// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_first_screen_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteFirstScreenSchedule _$RemoteFirstScreenScheduleFromJson(
        Map<String, dynamic> json) =>
    RemoteFirstScreenSchedule(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteFirstScreenScheduleToJson(
        RemoteFirstScreenSchedule instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      Id: json['_id'] as String?,
      provider: json['provider'] as String?,
      consumer: json['consumer'] as String?,
      branch: json['branch'] == null
          ? null
          : Branch.fromJson(json['branch'] as Map<String, dynamic>),
      offer: json['offer'] as String?,
      responseEmployee: json['responseEmployee'] as String?,
      requestNumber: json['requestNumber'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      step: json['step'] as String?,
      visitDate: (json['visitDate'] as num?)?.toInt(),
      createdAt: (json['createdAt'] as num?)?.toInt(),
      V: (json['__v'] as num?)?.toInt(),
      consumerRequest: json['consumerRequest'] == null
          ? null
          : ConsumerRequest.fromJson(
              json['consumerRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      '_id': instance.Id,
      'provider': instance.provider,
      'consumer': instance.consumer,
      'branch': instance.branch,
      'offer': instance.offer,
      'responseEmployee': instance.responseEmployee,
      'requestNumber': instance.requestNumber,
      'type': instance.type,
      'status': instance.status,
      'step': instance.step,
      'visitDate': instance.visitDate,
      'createdAt': instance.createdAt,
      '__v': instance.V,
      'consumerRequest': instance.consumerRequest,
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

ConsumerRequest _$ConsumerRequestFromJson(Map<String, dynamic> json) =>
    ConsumerRequest(
      Id: json['_id'] as String?,
      requestNumber: json['requestNumber'] as String?,
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
          ? const ItemName(en: '', ar: '')
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
