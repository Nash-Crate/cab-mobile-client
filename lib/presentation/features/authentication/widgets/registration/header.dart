import 'package:flutter/material.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/features/authentication/authentication.dart';
import 'package:mobile_library/mobile_library.dart';

/// header for registration contents
class RegistrationHeader extends StatelessWidget {
  /// constructor
  const RegistrationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const RegisterLeadingBack(),
        Text(
          t.auth.registration.title.toUpperCase(),
          style: context.textTheme.titleLarge?.copyWith(color: const Color.fromRGBO(21, 21, 21, 1)),
        ),
      ],
    );
  }
}
