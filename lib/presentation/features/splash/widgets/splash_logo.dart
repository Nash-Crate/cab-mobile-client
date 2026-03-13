import 'package:flutter/material.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_library/mobile_library.dart';

/// Splash logo
class SplashLogo extends StatefulWidget {
  /// constructor
  const SplashLogo({required this.visible, super.key});

  /// logo visibility toggle
  final bool visible;

  @override
  State<SplashLogo> createState() => _SplashLogoState();
}

class _SplashLogoState extends State<SplashLogo> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect:
          RelativeRectTween(
            begin: RelativeRect.fromSize(
              Rect.fromCenter(
                center: Offset(1.sw / 2, 1.sh / 2),
                width: 1.sw,
                height: 1.sh,
              ),
              Size(1.sw, 1.sh),
            ),
            end: RelativeRect.fromSize(
              Rect.fromCenter(
                center: Offset(1.sw / 2, (1.sh / 2) + 20),
                width: 1.sw,
                height: 1.sh,
              ),
              Size(1.sw, 1.sh),
            ),
          ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
          ),
      child: AnimatedOpacity(
        opacity: widget.visible ? 1 : 0,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 300),
        child: Center(
          child: SizedBox(
            width: 0.8.sw,
            height: 0.8.sw,
            child: const AppImage(Assets.imageLogo),
          ),
        ),
      ),
    );
  }
}
