import 'package:flutter/material.dart';
import 'package:mobile_client/presentation/constants/constants.dart';

// TODO(improve): improve
/// Header background
class HeaderBg extends StatelessWidget {
  /// constructor
  const HeaderBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.auth.headerBg.path),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.25),
            radius: 1,
            colors: <Color>[
              Color.fromRGBO(76, 208, 128, 0),
              Color.fromRGBO(0, 69, 28, .8),
              Colors.black87,
            ],
            stops: <double>[0, .4, .6],
          ),
        ),
      ),
    );
  }
}
