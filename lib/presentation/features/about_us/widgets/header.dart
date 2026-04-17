import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_library/mobile_library.dart';

/// About us header
class AboutUsHeader extends StatelessWidget {
  /// constructor
  const AboutUsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(80.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.aboutUs.headerBg.path),
            fit: BoxFit.fitWidth,
            opacity: .8,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(255, 215, 100, 0.9),
                Color.fromRGBO(255, 223, 132, 0.75),
                Color.fromRGBO(255, 223, 132, 0.6),
                Color.fromRGBO(255, 239, 194, 0.46),
                Color.fromRGBO(246, 235, 219, 0.5),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: .2.sh, bottom: 80.h, left: 80.w, right: 80.w),
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                Text(
                  t.aboutUs.header.bgTitle,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 107.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(255, 255, 255, .24),
                      height: 1.1,
                    ),
                  ),
                ),
                Text(
                  t.aboutUs.header.title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 107.5.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
