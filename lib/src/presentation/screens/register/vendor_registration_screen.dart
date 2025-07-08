import 'package:flutter/material.dart';
import '../../../domain/entities/vendor_registration_model.dart';
import 'widgets/registration_step1_view.dart';

class VendorRegistrationScreen extends StatelessWidget {
  const VendorRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VendorRegistrationModel vendorData = VendorRegistrationModel();

    return RegistrationStep1View(vendorData: vendorData);
  }
}
