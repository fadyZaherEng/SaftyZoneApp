import 'package:json_annotation/json_annotation.dart';

part 'request_installations_fees.g.dart';

@JsonSerializable()
class RequestInstallationsFees {
  final String? item;
  final List<int>? price;
  final bool? isComplete;

  const RequestInstallationsFees({
    this.item,
    this.price,
    this.isComplete,
  });

  factory RequestInstallationsFees.fromJson(Map<String, dynamic> json) =>
      _$RequestInstallationsFeesFromJson(json);

  Map<String, dynamic> toJson() => _$RequestInstallationsFeesToJson(this);
}
