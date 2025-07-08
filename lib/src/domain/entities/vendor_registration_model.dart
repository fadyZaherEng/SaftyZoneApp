class VendorRegistrationModel {
  // Step 1: Basic Company Details
  String? companyName;
  String? commercialRegistrationNo;
  String? whatsappNumber;
  String? email;

  // Step 2: Document Uploads
  DateTime? commercialRegistrationExpiryDate;
  String? commercialRegistrationDocumentPath;
  DateTime? civilDefensePermitExpiryDate;
  String? civilDefensePermitDocumentPath;

  // Step 3: Financial & Location Info
  String? address; // API expects this field
  String? location; // This is kept for backward compatibility
  double? latitude; // will be part of location.coordinates[1]
  double? longitude; // will be part of location.coordinates[0]
  String? bankName; // API expects this field
  String? bankAccountName; // This is kept for backward compatibility
  String? bankAccountNumber;
  bool? confirmationChecked;
  bool? termsChecked;

  // Post Registration Setup
  List<SystemFee> selectedSystemFees = [];
  bool hasAddedFees = false;
  bool hasAddedEmployees = false;
  bool hasAcceptedTerms = false;

  VendorRegistrationModel({
    this.companyName,
    this.commercialRegistrationNo,
    this.whatsappNumber,
    this.email,
    this.commercialRegistrationExpiryDate,
    this.commercialRegistrationDocumentPath,
    this.civilDefensePermitExpiryDate,
    this.civilDefensePermitDocumentPath,
    this.address,
    this.latitude,
    this.longitude,
    this.bankName,
    this.bankAccountNumber,
    this.confirmationChecked = false,
    this.termsChecked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'commercialRegistrationNumber': commercialRegistrationNo,
      'phoneNumber': whatsappNumber,
      'email': email,
      'commercialRegistration': {
        'filePath': commercialRegistrationDocumentPath,
        'expiryDate': commercialRegistrationExpiryDate?.millisecondsSinceEpoch
      },
      'civilDefensePermit': {
        'filePath': civilDefensePermitDocumentPath,
        'expiryDate': civilDefensePermitExpiryDate?.millisecondsSinceEpoch
      },
      'location': {
        'type': 'Point',
        'coordinates': [longitude ?? 30.123456, latitude ?? -97.654321]
      },
      'address': address ?? location,
      'bankName': bankName ?? bankAccountName,
      'bankAccountNumber': bankAccountNumber,
    };
  }
}

class SystemFee {
  final String systemId;
  final String systemName;
  final String iconPath;
  double? fee;
  bool isSelected;

  SystemFee({
    required this.systemId,
    required this.systemName,
    required this.iconPath,
    this.fee,
    this.isSelected = false,
  });
}
