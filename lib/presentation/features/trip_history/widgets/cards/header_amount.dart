import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip history card amount
class TripHistoryCardAmount extends StatelessWidget {
  /// constructor
  const TripHistoryCardAmount(this.amount, {super.key});

  /// Trip amount
  final double amount;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: context.colorScheme.secondary,
      fontSize: 52.sp,
      fontWeight: FontWeight.w600,
    );
    return RichText(
      text: TextSpan(
        text: amount.toReal.toString(),
        style: GoogleFonts.poppins(textStyle: style),
        children: [
          TextSpan(
            text: '.${amount.toFraction.toString().padLeft(2, '0')}',
            style: style.copyWith(fontSize: 40.sp),
          ),
          TextSpan(text: ' MRU', style: style),
        ],
      ),
    );
  }
}
