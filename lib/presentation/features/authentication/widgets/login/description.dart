import 'package:flutter/material.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_library/mobile_library.dart';

/// Login description
class LoginDescription extends StatelessWidget {
  /// constructor
  const LoginDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          t.auth.login.letsStart,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(146, 146, 146, 1),
          ),
        ),
        HSB(60.h),
      ],
    );
  }
}
