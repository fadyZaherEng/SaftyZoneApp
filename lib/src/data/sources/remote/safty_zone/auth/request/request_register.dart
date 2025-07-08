import 'package:json_annotation/json_annotation.dart';

part 'request_register.g.dart';

@JsonSerializable()
class RequestRegister {
  final String? companyName;
  final String? commercialRegistrationNumber;
  final String? phoneNumber;
  final String? email;
  final CommercialRegistration? commercialRegistration;
  final CivilDefensePermit? civilDefensePermit;
  final Location? location;
  final String? address;
  final String? bankName;
  final String? bankAccountNumber;

  const RequestRegister({
    this.companyName,
    this.commercialRegistrationNumber,
    this.phoneNumber,
    this.email,
    this.commercialRegistration,
    this.civilDefensePermit,
    this.location,
    this.address,
    this.bankName,
    this.bankAccountNumber,
  });

  factory RequestRegister.fromJson(Map<String, dynamic> json) =>
      _$RequestRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RequestRegisterToJson(this);
}

@JsonSerializable()
class CommercialRegistration {
  final String? filePath;
  final int? expiryDate;

  const CommercialRegistration({
    this.filePath,
    this.expiryDate,
  });

  factory CommercialRegistration.fromJson(Map<String, dynamic> json) =>
      _$CommercialRegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$CommercialRegistrationToJson(this);
}

@JsonSerializable()
class CivilDefensePermit {
  final String? filePath;
  final int? expiryDate;

  const CivilDefensePermit({
    this.filePath,
    this.expiryDate,
  });

  factory CivilDefensePermit.fromJson(Map<String, dynamic> json) =>
      _$CivilDefensePermitFromJson(json);

  Map<String, dynamic> toJson() => _$CivilDefensePermitToJson(this);
}

@JsonSerializable()
class Location {
  final String? type;
  final List<double>? coordinates;

  const Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
