import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/presentation/screens/installation_options/models/installation_fee_model.dart';

class RequestDetails extends Equatable {
  final Result result;
  final TermsAndConditions termsAndConditions;

  const RequestDetails({
    this.result = const Result(),
    this.termsAndConditions = const TermsAndConditions(),
  });

  @override
  List<Object?> get props => [result, termsAndConditions];
}

class ItemsPrice extends Equatable {
  final String Id;
  final ItemName itemName;
  final String type;
  final int price;
  final int quantity;

  const ItemsPrice({
    this.Id = "",
    this.itemName = const ItemName(),
    this.type = "",
    this.price = 0,
    this.quantity = 0,
  });

  @override
  List<Object?> get props => [Id, itemName, type, price, quantity];
}

class Offers extends Equatable {
  final String Id;
  final String provider;
  final int price;
  final String status;
  final int createdAt;
  final List<ItemsPrice> item;
  final int discount;
  final bool is_Primary;
  final int offerNumber;
  final int visitPrice;
  final int emergencyVisitPrice;
  final String billURL;
  final int installationPrice;
  final int itemSupplyPrice;

  const Offers({
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

  @override
  List<Object?> get props => [
        Id,
        provider,
        price,
        status,
        createdAt,
        item,
        discount,
        is_Primary,
        offerNumber,
        visitPrice,
        emergencyVisitPrice,
        billURL,
        installationPrice,
        itemSupplyPrice,
      ];
}

class Result extends Equatable {
  final String Id;
  final String consumer;
  final Branch branch;
  final String requestNumber;
  final int numberOfVisits;
  final int duration;
  final String systemType;
  final int space;
  final List<Items> alarmItems;
  final List<Items> fireExtinguisherItem;
  final List<Items> fireSystemItem;
  final String requestType;
  final String status;
  final int createdAt;
  final List<Offers> offers;

  const Result({
    this.Id = "",
    this.consumer = "",
    this.branch = const Branch(),
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

  @override
  List<Object?> get props => [
        Id,
        consumer,
        branch,
        requestNumber,
        systemType,
        space,
        requestType,
        status,
        createdAt,
        alarmItems,
        fireExtinguisherItem,
        fireSystemItem,
        numberOfVisits,
        duration,
        offers,
      ];
}

class Items extends Equatable {
  final ItemId itemId;
  final int quantity;
  final String id;

  const Items({
    this.itemId = const ItemId(),
    this.quantity = 0,
    this.id = "",
  });

  @override
  List<Object?> get props => [itemId, quantity, id];
}

class ItemId extends Equatable {
  final String Id;
  final ItemName itemName;
  final String type;

  const ItemId({
    this.Id = "",
    this.itemName = const ItemName(),
    this.type = "",
  });

  @override
  List<Object?> get props => [Id, itemName, type];
}

class TermsAndConditions extends Equatable {
  final String Id;
  final Employee employee;
  final String company;
  final List<Clauses> clauses;
  final int createdAt;

  const TermsAndConditions({
    this.Id = "",
    this.employee = const Employee(),
    this.company = "",
    this.clauses = const [],
    this.createdAt = 0,
  });

  @override
  List<Object?> get props => [Id, employee, company, clauses, createdAt];
}

class Clauses extends Equatable {
  final String text;
  final String Id;

  const Clauses({
    this.text = '',
    this.Id = '',
  });

  @override
  List<Object?> get props => [text, Id];
}
