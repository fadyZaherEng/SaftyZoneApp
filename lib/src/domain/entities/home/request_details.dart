import 'package:equatable/equatable.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';

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

class Result extends Equatable {
  final String Id;
  final String consumer;
  final Branch branch;
  final String requestNumber;
  final String systemType;
  final int space;

  final List<Items> alarmItems;
  final List<Items> fireExtinguisherItem;
  final List<Items> fireSystemItem;
  final String requestType;
  final String status;
  final int createdAt;

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
      ];
}

class Items extends Equatable {
  final ItemId itemId;

  const Items({
    this.itemId = const ItemId(),
  });

  @override
  List<Object?> get props => [itemId];
}

class ItemId extends Equatable {
  final String Id;
  final String itemName;
  final String type;
  final int Quntity;

  const ItemId({
    this.Id = "",
    this.itemName = "",
    this.type = "",
    this.Quntity = 0,
  });

  @override
  List<Object?> get props => [Id, itemName, type, Quntity];
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
