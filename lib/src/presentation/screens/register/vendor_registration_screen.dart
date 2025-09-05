import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import '../../../domain/entities/vendor_registration_model.dart';
import 'widgets/registration_step1_view.dart';
import 'package:http/http.dart' as http;

class VendorRegistrationScreen extends StatefulWidget {
  final bool isEditMode;

  const VendorRegistrationScreen({
    super.key,
    required this.isEditMode,
  });

  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  late Future<VendorRegistrationModel?> _futureProfile;

  @override
  void initState() {
    super.initState();
    _futureProfile = fetchProfile();
  }

  Future<VendorRegistrationModel?> fetchProfile() async {
    final url = Uri.parse("${APIKeys.baseUrl}/api/provider/profile");
    GetTokenUseCase(injector())();

    final response = await http.get(
      url,
       headers: {
         "Content-Type": "application/json",
         "Authorization": "Bearer ${GetTokenUseCase(injector())()}",
       },
    );
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    print("Token: ${GetTokenUseCase(injector())()}");

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return VendorRegistrationModel.fromJson(decoded['data']);
    } else {
      debugPrint("Error: ${response.statusCode}");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEditMode) {
      VendorRegistrationModel vendorData = VendorRegistrationModel();

      return RegistrationStep1View(vendorData: vendorData);
    }
    return FutureBuilder<VendorRegistrationModel?>(
      future: _futureProfile,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body:
                Center(child: SpinKitDoubleBounce(color: ColorSchemes.primary)),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(
              child: Text("No profile data found"),
            ),
          );
        }

        // ✅ عندك البيانات دلوقتي
        final vendorData = snapshot.data!;

        return RegistrationStep1View(vendorData: vendorData);
      },
    );
  }
}
