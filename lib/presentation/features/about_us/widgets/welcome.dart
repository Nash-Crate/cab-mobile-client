import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_library/mobile_library.dart';

/// About us welcome
class AboutUsWelcome extends StatelessWidget {
  /// constructor
  const AboutUsWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            style: context.textTheme.bodyLarge,
            t.aboutUs.welcome.title(
              title: (text) => TextSpan(
                text: text,
                style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.secondary),
              ),
            ),
          ),
          HSB(40.h),
          Text(
            t.aboutUs.welcome.description,
            textAlign: TextAlign.justify,
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
    );
  }
}
