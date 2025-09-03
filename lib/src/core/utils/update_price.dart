import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/send_price_request.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';

Future<Map<String, dynamic>?> updateOffer(
  String baseUrl, {
  required String offerId,
  required int? price,
  required int? visitPrice,
  required int? emergencyVisitPrice,
  List<Item>? items,
}) async {
  print("Update Offer Called with offerId: $offerId");
  final url = Uri.parse('$baseUrl/api/provider/offer/$offerId');
  try {
    final token = GetTokenUseCase(injector())();
    debugPrint("Calling: $url");
    debugPrint("Token: $token");
    debugPrint("Body: ${jsonEncode({
          "price": price,
          "visitPrice": visitPrice,
          "emergencyVisitPrice": emergencyVisitPrice,
          "item": items?.map((e) => e.toJson()).toList() ?? [],
        })}");

    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "price": price,
        "visitPrice": visitPrice,
        "emergencyVisitPrice": emergencyVisitPrice,
        "item": items?.map((e) => e.toJson()).toList() ?? [],
      }),
    );

    debugPrint("\n===== [OfferApi] Update Offer Response =====");
    debugPrint("Status: ${response.statusCode}");
    debugPrint("Headers: ${response.headers}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint(const JsonEncoder.withIndent('  ').convert(data));
      return data;
    } else {
      debugPrint("Raw Response: ${response.body}");
    }
  } catch (e, s) {
    debugPrint("\n===== [OfferApi] Update Offer Error =====");
    debugPrint(e.toString());
    debugPrint(s.toString());
  }
  return null;
}
