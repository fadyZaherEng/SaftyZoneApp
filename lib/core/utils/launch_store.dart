// import 'dart:io';
// import 'package:flutter/widgets.dart';
// import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void launchStore() async {
//   String androidPackageName = "com.sprinteye.mofa.app";
//   String iOSAppId = "";
//   String huaweiAppId = "";
//
//   if (Platform.isIOS) {
//     final url = 'https://apps.apple.com/app/id$iOSAppId';
//     try {
//       launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   } else {
//     if (await HmsApiAvailability().isHMSAvailableWithApkVersion(28) != 1) {
//       final url = "https://appgallery.huawei.com/app/$huaweiAppId";
//       try {
//         launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     } else {
//       final url =
//           'https://play.google.com/store/apps/details?id=$androidPackageName';
//       try {
//         launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     }
//   }
// }
