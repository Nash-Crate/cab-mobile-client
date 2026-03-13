import 'package:flutter/material.dart';
import 'package:mobile_library/mobile_library.dart';

/// Extended floating action button for home page's use
class HomeExtendedFab extends StatelessWidget {
  /// constructor
  const HomeExtendedFab({
    required this.fillColor,
    required this.iconPath,
    required this.label,
    required this.onPressed,
    super.key,
  });

  /// fill color of the button
  final Color fillColor;

  /// icon of the button
  final String iconPath;

  /// label of the button
  final String label;

  /// on pressed callback
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(31.sp))),
      fillColor: fillColor,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSvgImage(iconPath, height: 130.h, width: 130.w),
          SizedBox(
            width: 750.w,
            height: 242.h,
            child: Center(
              child: Text(
                label,
                style: context.textTheme.labelSmall,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
