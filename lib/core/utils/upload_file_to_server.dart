import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<bool> uploadFileToServer(File pickedFile, String uploadUrl) async {
  try {
    final bytes = await pickedFile.readAsBytes();

    debugPrint("📡 Uploading to: $uploadUrl");

    final response = await http.put(
      Uri.parse(uploadUrl),
      headers: {
        'Content-Type': 'file/pdf',
      },
      body: bytes,
    );

    if (response.statusCode == 200) {
      debugPrint("✅ Upload success");
      return true;
    } else {
      debugPrint("❌ Upload failed: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    debugPrint("❌ Error: $e");
    return false;
  }
}
