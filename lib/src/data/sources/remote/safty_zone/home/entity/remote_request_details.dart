import 'package:json_annotation/json_annotation.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_requests.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/presentation/screens/installation_options/models/installation_fee_model.dart';

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
class RemoteItemsPrice {
  @JsonKey(name: '_id')
  final String Id;
  final ItemName itemName;
  final String type;
  final int price;
  final int quantity;

  const RemoteItemsPrice({
    this.Id = "",
    this.itemName = const ItemName(),
    this.type = "",
    this.price = 0,
    this.quantity = 0,
  });

  factory RemoteItemsPrice.fromJson(Map<String, dynamic> json) =>
      _$RemoteItemsPriceFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteItemsPriceToJson(this);
}

@JsonSerializable()
class RemoteOffers {
  @JsonKey(name: '_id')
  final String Id;
  final String provider;
  final int price;
  final String status;
  final int createdAt;
  final List<RemoteItemsPrice> item;
  final int discount;
  final bool is_Primary;
  final int offerNumber;
  final int visitPrice;
  final int emergencyVisitPrice;
  final String billURL;
  final int installationPrice;
  final int itemSupplyPrice;

  const RemoteOffers({
    this.Id = "",
    this.provider = "",
    this.price = 0,
    this.status = "",
    this.createdAt = 0,
    this.item = const [],
    this.discount = 0,
    this.is_Primary = false,
    this.offerNumber = 0,
    this.visitPrice = 0,
    this.emergencyVisitPrice = 0,
    this.billURL = "",
    this.installationPrice = 0,
    this.itemSupplyPrice = 0,
  });

  factory RemoteOffers.fromJson(Map<String, dynamic> json) =>
      _$RemoteOffersFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteOffersToJson(this);
}
extension RemoteItemsPriceExtension on RemoteItemsPrice {
  ItemsPrice mapToDomain() {
    return ItemsPrice(
      Id: Id,
      itemName: itemName,
      type: type,
      price: price,
      quantity: quantity,
    );
  }
}

extension RemoteOffersExtension on RemoteOffers {
  Offers mapToDomain() {
    return Offers(
      Id: Id,
      provider: provider,
      price: price,
      status: status,
      createdAt: createdAt,
      item: item.map((e) => e.mapToDomain()).toList(),
      discount: discount,
      is_Primary: is_Primary,
      offerNumber: offerNumber,
      visitPrice: visitPrice,
      emergencyVisitPrice: emergencyVisitPrice,
      billURL: billURL,
      installationPrice: installationPrice,
      itemSupplyPrice: itemSupplyPrice,
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
  final int? numberOfVisits;
  final int? duration;
  final String? systemType;
  final int? space;
  final String? requestType;
  final String? status;
  final int? createdAt;
  final List<RemoteItems>? alarmItems;
  final List<RemoteItems>? fireExtinguisherItem;
  final List<RemoteItems>? fireSystemItem;
  final List<RemoteOffers>? offers;

  const RemoteResult({
    this.Id = "",
    this.consumer = "",
    this.branch = const RemoteBranch(),
    this.requestNumber = "",
    this.systemType = "",
    this.space = 0,
    this.requestType = "",
    this.status = "",
    this.createdAt = 0,
    this.alarmItems = const [],
    this.fireExtinguisherItem = const [],
    this.fireSystemItem = const [],
    this.numberOfVisits = 0,
    this.duration = 0,
    this.offers = const [],
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
      requestType: requestType ?? "",
      status: status ?? "",
      createdAt: createdAt ?? 0,
      alarmItems: alarmItems?.map((e) => e.mapToDomain()).toList() ?? [],
      fireExtinguisherItem:
          fireExtinguisherItem?.map((e) => e.mapToDomain()).toList() ?? [],
      fireSystemItem:
          fireSystemItem?.map((e) => e.mapToDomain()).toList() ?? [],
      numberOfVisits: numberOfVisits ?? 0,
      duration: duration ?? 0,
      offers: offers?.map((e) => e.mapToDomain()).toList() ?? [],
    );
  }
}

@JsonSerializable()
class RemoteItems {
  @JsonKey(name: 'item_id')
  final RemoteItemId? itemId;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String id;

  const RemoteItems({
    this.itemId = const RemoteItemId(),
    this.quantity = 0,
    this.id = "",
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
      id: id ?? "",
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
  final ItemName itemName;
  final String? type;

  const RemoteItemId({
    this.Id = "",
    this.itemName = const ItemName(),
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
      itemName: itemName,
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
