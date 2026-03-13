import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_library/mobile_library.dart';

/// Support card for contacts
class ContactUsSupportCard extends StatelessWidget {
  /// constructor
  const ContactUsSupportCard({
    required this.title,
    required this.svgIcon,
    required this.data,
    required this.onPressed,
    super.key,
  });

  /// Support card title
  final String title;

  /// Support card icon
  final Widget svgIcon;

  /// Support card data
  final String data;

  /// on press callback
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(30.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(67, 55, 24, 0.1),
                  spreadRadius: -14.sp,
                  blurRadius: 72.sp,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(40, 40, 40, 1),
                    ),
                  ),
                ),
                HSB(60.h),
                Text(
                  data,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 38.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(149, 149, 149, 1),
                    ),
                  ),
                ),
                HSB(10.h),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 180.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 247, 225, 1),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200.r)),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 140.w,
              height: 140.h,
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  radius: 0.6,
                  colors: <Color>[
                    Color.fromRGBO(255, 208, 71, 0.24),
                    Color.fromRGBO(255, 247, 225, 0.5),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(200.r)),
              ),
            ),
          ),
          Positioned(top: 30.h, right: 30.w, child: svgIcon),
        ],
      ),
    );
  }
}
