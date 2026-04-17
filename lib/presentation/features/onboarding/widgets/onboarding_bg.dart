import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_library/mobile_library.dart';

/// Onboarding background
class OnboardingBackground extends StatelessWidget {
  /// constructor
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: AppSvgImage(
              Assets.onboarding.topIllustration.path,
              width: 1.sw,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: AppSvgImage(
              Assets.onboarding.bottomIllustration.path,
              height: .3.sh,
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: const SizedBox.expand(),
          ),
        ],
      ),
    );
  }
}
