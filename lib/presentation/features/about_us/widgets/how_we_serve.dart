import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/about_us/about_us.dart';
import 'package:mobile_library/mobile_library.dart';

/// About us how we serve
class AboutUsHowWeServe extends StatelessWidget {
  /// constructor
  const AboutUsHowWeServe({super.key});

  @override
  Widget build(BuildContext context) {
    final stepT = t.aboutUs.serve.steps;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.aboutUs.serve.title,
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 77.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 300.w, child: AppSvgImage(Assets.aboutUs.leftSeparator.path)),
          HSB(40.h),
          HowWeServeCard(
            title: stepT.booking.title,
            description: stepT.booking.description,
            icon: Assets.aboutUs.serveBookingIcon.path,
            step: 1,
          ),
          HowWeServeCard(
            title: stepT.drivers.title,
            description: stepT.drivers.description,
            icon: Assets.aboutUs.serveDriversIcon.path,
            step: 2,
            reverse: true,
          ),
          HowWeServeCard(
            title: stepT.tracking.title,
            description: stepT.tracking.description,
            icon: Assets.aboutUs.serveTrackingIcon.path,
            step: 3,
          ),
          HowWeServeCard(
            title: stepT.payment.title,
            description: stepT.payment.description,
            icon: Assets.aboutUs.servePaymentIcon.path,
            step: 4,
            reverse: true,
          ),
        ],
      ),
    );
  }
}
