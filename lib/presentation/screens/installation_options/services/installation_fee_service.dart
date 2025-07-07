import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hatif_mobile/data/sources/remote/api_key.dart';
 import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/domain/usecase/get_token_use_case.dart';
import 'package:http/http.dart' as http;
import '../models/installation_fee_model.dart';

class InstallationFeeService {
  final String baseUrl;
  final http.Client _client;

  InstallationFeeService({
    String? baseUrl,
    http.Client? client,
  })  : baseUrl = baseUrl ??
            'http://safty-zone-env.eba-rhpc9ydc.us-east-1.elasticbeanstalk.com',
        _client = client ?? http.Client();

  Future<Map<String, dynamic>> saveInstallationFees(
      InstallationFeeModel model) async {
    final url = Uri.parse(
        'http://safty-zone-env.eba-rhpc9ydc.us-east-1.elasticbeanstalk.com/api/provider/installation-fees');
    final token = GetTokenUseCase(injector())();

    if (token == null) {
      return {
        'success': false,
        'message': 'No authentication token found',
      };
    }

    try {
      final response = await _client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(model.toJson()),
      );

      debugPrint(
          'Save Installation Fees - Response code: ${response.statusCode}');
      debugPrint('Save Installation Fees - Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message':
              responseData['message'] ?? 'Failed to save installation fees',
          'error': responseData,
        };
      }
    } catch (e) {
      debugPrint('Exception during API call: ${e.toString()}');

      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getInstallationFees() async {
    final url = Uri.parse(
        'http://safty-zone-env.eba-rhpc9ydc.us-east-1.elasticbeanstalk.com/api/provider/installation-fees');
    final token = GetTokenUseCase(injector())();

    if (token == null) {
      return {
        'success': false,
        'message': 'No authentication token found',
      };
    }

    try {
      final response = await _client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message':
              responseData['message'] ?? 'Failed to get installation fees',
          'error': responseData,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getInstallationFeesBySystemComponent(
      String alarmType, String systemComponentCode) async {
    final url = Uri.parse(
        '${APIKeys.baseUrl}/api/provider/item-management/${systemComponentCode == "earlyWarning" ? "alarm-item" : "fire-system-item"}/$alarmType?page=1&limit=100');

    debugPrint(
        '${APIKeys.baseUrl}/api/provider/item-management/${systemComponentCode == "earlyWarning" ? "alarm-item" : "fire-system-item"}/$alarmType?alarmType=loop&page=1&limit=100');
    final token = GetTokenUseCase(injector())();

    if (token == null) {
      return {
        'success': false,
        'message': 'No authentication token found',
      };
    }

    try {
      final response = await _client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<Map<String, dynamic>> items = [];
        if (responseData is Map && responseData['result'] is List) {
          for (var itemJson in responseData['result']) {
            items.add(Map<String, dynamic>.from(itemJson));
          }
        }
        return {
          'success': true,
          'data': items,
          'count': responseData['count'] ?? items.length,
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              responseData['message'] ?? 'Failed to fetch installation fees',
          'error': responseData,
        };
      }
    } catch (e) {
      debugPrint('Exception during API call: ${e.toString()}');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> saveItemInstallationFee({
    required String providerId,
    required String itemId,
    required List<double> price,
    required bool isComplete,
  }) async {
    final url = Uri.parse('$baseUrl/api/provider/installation-fees');
    final token = GetTokenUseCase(injector())();

    if (token == null) {
      return {
        'success': false,
        'message': 'No authentication token found',
      };
    }

    final requestBody = {
      "provider": providerId,
      "item": itemId,
      "price": price,
    };

    try {
      final response = await _client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint(
          'Save Item Installation Fee - Response code: ${response.statusCode}');
      debugPrint(
          'Save Item Installation Fee - Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData,
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              responseData['message'] ?? 'Failed to save installation fee',
          'error': responseData,
        };
      }
    } catch (e) {
      debugPrint(
          'Exception during save item installation fee: ${e.toString()}');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> saveItemInstallationFeeDirect({
    required String itemId,
    required List<double> price,
    bool isComplete = true,
  }) async {
    final url = Uri.parse('$baseUrl/api/provider/installation-fees');
    final token = GetTokenUseCase(injector())();

    if (token == null) {
      return {
        'success': false,
        'message': 'No authentication token found',
      };
    }

    final requestBody = {
      "item": itemId,
      "price": price,
      "isComplete": isComplete,
    };

    try {
      final response = await _client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData,
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              responseData['message'] ?? 'Failed to save installation fee',
          'error': responseData,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }
}
