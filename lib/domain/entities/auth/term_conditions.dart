import 'package:equatable/equatable.dart';

class TermConditions extends Equatable {
  final bool success;
  final Data data;

  const TermConditions({
    this.success = false,
    this.data = const Data(),
  });

  @override
  List<Object> get props => [success, data];
}

class Data extends Equatable {
  final String employee;
  final String company;
  final String responsibleEmployeeName;
  final List<Clauses> clauses;
  final int createdAt;
  final String Id;
  final int V;

  const Data({
    this.employee = '',
    this.company = '',
    this.responsibleEmployeeName = '',
    this.clauses = const [],
    this.createdAt = 0,
    this.Id = '',
    this.V = 0,
  });

  @override
  List<Object> get props => [
        employee,
        company,
        responsibleEmployeeName,
        clauses,
        createdAt,
        Id,
        V,
      ];
}

class Clauses extends Equatable {
  final String text;
  final String Id;

  const Clauses({
    this.text = '',
    this.Id = '',
  });

  @override
  List<Object> get props => [text, Id];
}
