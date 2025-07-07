import 'package:json_annotation/json_annotation.dart';

part 'request_term_conditions.g.dart';

@JsonSerializable()
class RequestTermConditions {
  final String? employee;
  final String? responsibleEmployeeName;
  final List<Clauses>? clauses;
  final bool? isFirstTime;

  const RequestTermConditions({
    this.employee,
    this.responsibleEmployeeName,
    this.clauses,
    this.isFirstTime,
  });

  factory RequestTermConditions.fromJson(Map<String, dynamic> json) =>
      _$RequestTermConditionsFromJson(json);

  Map<String, dynamic> toJson() => _$RequestTermConditionsToJson(this);
}

@JsonSerializable()
class Clauses {
  final String? text;

  const Clauses({
    this.text,
  });

  factory Clauses.fromJson(Map<String, dynamic> json) =>
      _$ClausesFromJson(json);

  Map<String, dynamic> toJson() => _$ClausesToJson(this);
}
