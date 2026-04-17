import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/about_us/about_us.dart';
import 'package:mobile_library/mobile_library.dart';

/// About us our mission
class AboutUsOurMission extends StatelessWidget {
  /// constructor
  const AboutUsOurMission({super.key});

  @override
  Widget build(BuildContext context) {
    // fixme: failed to apply this overlay
    // Padding(
    //   padding: EdgeInsets.symmetric(vertical: 120.h),
    //   child: AppSvgImage(Assets.aboutUsOurMissionBgVector, height: 1.sh),
    // ),
    return CustomPaint(
      painter: BackgroundPainter(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 120.h),
        child: Column(
          children: [
            HSB(250.h),
            Text(
              t.aboutUs.mission.title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 77.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 300.w, child: AppSvgImage(Assets.aboutUs.centerSeparator.path)),
            HSB(40.h),
            Text(
              t.aboutUs.mission.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(65, 65, 65, 1),
                  height: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
