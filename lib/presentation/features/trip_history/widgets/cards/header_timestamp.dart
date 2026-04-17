import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip history card timestamp
class TripHistoryCardTimestamp extends StatelessWidget {
  /// constructor
  const TripHistoryCardTimestamp(this.timestamp, {super.key});

  /// Trip history card timestamp
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSvgImage(
          LibAssets.svg.calendar.path,
          width: 50.w,
          height: 50.h,
          package: 'mobile_library',
        ),
        WSB(30.w),
        Text(
          DateFormat('dd MMM yyyy, HH:mm').format(timestamp),
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: const Color.fromRGBO(107, 130, 147, 1),
              fontSize: 46.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
