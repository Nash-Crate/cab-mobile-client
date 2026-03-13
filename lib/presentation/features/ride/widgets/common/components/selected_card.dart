import 'package:flutter/material.dart';
import 'package:mobile_library/mobile_library.dart';

/// Selected card
class SelectedCard extends StatelessWidget {
  /// constructor
  const SelectedCard({
    required this.child,
    required this.backgroundColor,
    this.padding,
    super.key,
  });

  /// Card child
  final Widget child;

  /// Card background color
  final Color backgroundColor;

  /// Card padding
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30.r)),
      child: Container(
        padding: padding ?? EdgeInsets.all(30.sp),
        decoration: BoxDecoration(color: backgroundColor),
        child: child,
      ),
    );
  }
}
