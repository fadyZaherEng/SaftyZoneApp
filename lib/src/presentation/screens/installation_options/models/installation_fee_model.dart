enum SystemType {
  earlyWarning,
  fireSuppression,
}

class InstallationFeeModel {
  final Map<SystemType, double> fees;

  InstallationFeeModel({
    required this.fees,
  });

  // Convert to JSON for API
  Map<String, dynamic> toJson() {
    Map<String, dynamic> feeMap = {};

    fees.forEach((key, value) {
      switch (key) {
        case SystemType.earlyWarning:
          feeMap['earlyWarningFee'] = value;
          break;
        case SystemType.fireSuppression:
          feeMap['fireSuppressionFee'] = value;
          break;
      }
    });

    return feeMap;
  }

  // Create from JSON response
  factory InstallationFeeModel.fromJson(Map<String, dynamic> json) {
    Map<SystemType, double> feeMap = {};

    if (json['earlyWarningFee'] != null) {
      feeMap[SystemType.earlyWarning] =
          double.parse(json['earlyWarningFee'].toString());
    }

    if (json['fireSuppressionFee'] != null) {
      feeMap[SystemType.fireSuppression] =
          double.parse(json['fireSuppressionFee'].toString());
    }

    return InstallationFeeModel(fees: feeMap);
  }
}

class SystemComponent {
  final String id;
  final String name;
  final String code;
  final String icon;

  SystemComponent({
    required this.id,
    required this.name,
    required this.code,
    required this.icon,
  });
}

// New models for API response
class ItemDetail {
  final String id;
  final String itemName;
  final String itemCode;
  final String image;
  final String supplierName;
  final double supplyPrice;
  final bool isDeleted;
  final String adminId;
  final String type;
  final String alarmType;
  final String subCategory;
  final DateTime createdAt;
  final DateTime updatedAt;

  ItemDetail({
    required this.id,
    required this.itemName,
    required this.itemCode,
    required this.image,
    required this.supplierName,
    required this.supplyPrice,
    required this.isDeleted,
    required this.adminId,
    required this.type,
    required this.alarmType,
    required this.subCategory,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemDetail.fromJson(Map<String, dynamic> json) {
    return ItemDetail(
      id: json['_id'] ?? '',
      itemName: json['itemName'] ?? '',
      itemCode: json['itemCode'] ?? '',
      image: json['image'] ?? '',
      supplierName: json['supplierName'] ?? '',
      supplyPrice: (json['supplyPrice'] ?? 0).toDouble(),
      isDeleted: json['isDeleted'] ?? false,
      adminId: json['admin'] ?? '',
      type: json['type'] ?? '',
      alarmType: json['alarmType'] ?? '',
      subCategory: json['subCategory'] ?? '',
      createdAt:
      DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
      DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class InstallationFeeItem {
  final String id;
  final String providerId;
  final ItemDetail item;
  final bool isDeleted;
  final List<double> price;
  final DateTime createdAt;

  InstallationFeeItem({
    required this.id,
    required this.providerId,
    required this.item,
    required this.isDeleted,
    required this.price,
    required this.createdAt,
  });

  factory InstallationFeeItem.fromJson(Map<String, dynamic> json) {
    return InstallationFeeItem(
      id: json['_id'],
      providerId: json['provider'],
      item: ItemDetail.fromJson(json['item']),
      isDeleted: json['isDeleted'] ?? false,
      price: List<double>.from(json['price'].map((x) => x.toDouble())),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }
}
