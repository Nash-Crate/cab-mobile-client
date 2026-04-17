import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_library/mobile_library.dart';

/// About us how we serve card
class HowWeServeCard extends StatelessWidget {
  /// constructor
  const HowWeServeCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.step,
    super.key,
    this.reverse = false,
  });

  /// title
  final String title;

  /// description
  final String description;

  /// icon
  final String icon;

  /// step
  final int step;

  /// reverse the icon and title positions
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final contentList = [
      Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: 0.2.sw,
            height: 0.1.sh,
            child: AppSvgImage(icon),
          ),
          Positioned(
            right: -30.w,
            bottom: -30.w,
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4.h),
                      blurRadius: 79.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.15),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    step.toString(),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(255, 214, 98, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      WSB(50.w),
      Expanded(
        child: Column(
          crossAxisAlignment: reverse ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              description,
              maxLines: 3,
              textAlign: reverse ? TextAlign.end : TextAlign.start,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 38.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(94, 94, 94, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    final row = Row(children: reverse ? contentList.reversed.toList() : contentList);
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            row,
            Positioned(
              bottom: -80.h,
              left: reverse ? -140.w : null,
              right: reverse ? null : -140.w,
              child: SizedBox(
                height: 150.h,
                child: AppSvgImage(
                  reverse
                      ? Assets.aboutUs.circleArrowAntiClockwise.path
                      : Assets.aboutUs.circleArrowClockwise.path,
                ),
              ),
            ),
          ],
        ),
        HSB(100.h),
      ],
    );
  }
}
