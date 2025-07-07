import 'package:flutter/material.dart';
import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/domain/usecase/get_token_use_case.dart';
import 'package:hatif_mobile/domain/usecase/get_user_verification_data_use_case.dart';
import 'package:hatif_mobile/domain/usecase/getauthenticate_use_case.dart';

class AuthStatusWidget extends StatefulWidget {
  const AuthStatusWidget({super.key});

  @override
  State<AuthStatusWidget> createState() => _AuthStatusWidgetState();
}

class _AuthStatusWidgetState extends State<AuthStatusWidget> {
  bool _isAuthenticated() {
    final token = GetTokenUseCase(injector())();
    final isAuth = GetIsAuthenticationUseCase(injector())();
    return token.isNotEmpty && isAuth;
  }

  String userStatus = '';

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    userStatus =
        (await GetUserVerificationDataUseCase(injector())())?.status ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = _isAuthenticated();
    final token = GetTokenUseCase(injector())();

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isAuthenticated ? Colors.green.shade100 : Colors.red.shade100,
        border: Border.all(
          color: isAuthenticated ? Colors.green : Colors.red,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                isAuthenticated ? Icons.check_circle : Icons.error,
                color: isAuthenticated ? Colors.green : Colors.red,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                isAuthenticated ? 'Authenticated' : 'Not Authenticated',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isAuthenticated
                      ? Colors.green.shade800
                      : Colors.red.shade800,
                ),
              ),
            ],
          ),
          if (token != null) ...[
            const SizedBox(height: 4),
            Text(
              'Token: ${token.length > 20 ? "${token.substring(0, 20)}..." : token}',
              style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
            ),
          ],
          if (userStatus != null) ...[
            const SizedBox(height: 4),
            Text(
              'Status: $userStatus',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}

/// Extension to easily add auth status to any page for debugging
extension AuthStatusExtension on Widget {
  Widget withAuthStatus() {
    return Column(
      children: [
        const AuthStatusWidget(),
        Expanded(child: this),
      ],
    );
  }
}
