import 'package:flutter/foundation.dart';

enum Environment {
  dev,
  staging,
  prod,
}

class AppConfig {
  late Environment _environment;
  late String _apiBaseUrl;

  Environment get environment => _environment;
  String get apiBaseUrl => _apiBaseUrl;

  Future<void> init() async {
    // You can read this from a config file or environment variables
    // For now, we'll hard-code the dev environment
    _environment = Environment.dev;

    // Set API URL based on environment
    switch (_environment) {
      case Environment.dev:
        _apiBaseUrl = 'https://dev-api.safetyzone.com/api/v1/';
        break;
      case Environment.staging:
        _apiBaseUrl = 'https://staging-api.safetyzone.com/api/v1/';
        break;
      case Environment.prod:
        _apiBaseUrl = 'https://api.safetyzone.com/api/v1/';
        break;
    }

    debugPrint('AppConfig initialized with environment: $_environment');
    debugPrint('Base URL: $_apiBaseUrl');
  }
}
