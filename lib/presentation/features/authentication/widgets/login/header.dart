import 'package:flutter/material.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_library/mobile_library.dart';

/// header for Login contents
class LoginHeader extends StatelessWidget {
  /// constructor
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Text(
        t.auth.login.welcome.toUpperCase(),
        style: context.textTheme.displayLarge,
      ),
    );
  }
}
