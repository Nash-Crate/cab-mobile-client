import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mobile_library/mobile_library.dart';

/// BackgroundPainter painter
class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintBg = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(0, size.height),
        <Color>[
          const Color.fromRGBO(201, 250, 220, .2),
          const Color.fromRGBO(255, 255, 255, 0),
        ],
      )
      ..style = PaintingStyle.fill;

    final pathBg = Path()
      ..moveTo(-size.width * 1.5, size.height)
      ..quadraticBezierTo(size.width * .5, -size.height, size.width * 2.5, size.height);

    canvas.drawPath(pathBg, paintBg);

    final paint = Paint()
      ..color = Colors.indigoAccent
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(0, size.height + 200.h),
        <Color>[
          const Color.fromRGBO(201, 250, 220, 1),
          const Color.fromRGBO(201, 250, 220, 0),
          const Color.fromRGBO(255, 255, 255, 0),
        ],
        <double>[
          0,
          0.8,
          0.9,
        ],
      )
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(-size.width * 1.5, size.height + 200.h)
      ..quadraticBezierTo(
        size.width * .5,
        -size.height + 200.h,
        size.width * 2.5,
        size.height + 200.h,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
