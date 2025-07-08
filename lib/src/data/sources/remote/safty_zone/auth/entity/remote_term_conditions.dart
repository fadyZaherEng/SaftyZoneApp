import 'package:safety_zone/src/domain/entities/auth/term_conditions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_term_conditions.g.dart';

@JsonSerializable()
class RemoteTermConditions {
  final bool? success;
  final RemoteData? data;

  const RemoteTermConditions({
    this.success = false,
    this.data = const RemoteData(),
  });

  factory RemoteTermConditions.fromJson(Map<String, dynamic> json) =>
      _$RemoteTermConditionsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteTermConditionsToJson(this);
}

extension RemoteTermConditionsExtension on RemoteTermConditions {
  TermConditions toDomain() => TermConditions(
        success: success ?? false,
        data: data?.toDomain() ?? const Data(),
      );
}

@JsonSerializable()
class RemoteData {
  final String? employee;
  final String? company;
  final String? responsibleEmployeeName;
  final List<RemoteClauses>? clauses;
  final int? createdAt;
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: '__v')
  final int? V;

  const RemoteData({
    this.employee = '',
    this.company = '',
    this.responsibleEmployeeName = '',
    this.clauses = const [],
    this.createdAt = 0,
    this.Id = '',
    this.V = 0,
  });

  factory RemoteData.fromJson(Map<String, dynamic> json) =>
      _$RemoteDataFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDataToJson(this);
}

extension RemoteDataExtension on RemoteData {
  Data toDomain() => Data(
        employee: employee ?? '',
        company: company ?? '',
        responsibleEmployeeName: responsibleEmployeeName ?? '',
        clauses: clauses?.map((e) => e.toDomain()).toList() ?? [],
        createdAt: createdAt ?? 0,
        Id: Id ?? '',
        V: V ?? 0,
      );
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

extension RemoteClausesExtension on RemoteClauses {
  Clauses toDomain() => Clauses(
        text: text ?? '',
        Id: Id ?? '',
      );
}
