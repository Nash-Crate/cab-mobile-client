import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_library/mobile_library.dart';

/// Gender field
class GenderField extends StatelessWidget {
  /// Constructor
  const GenderField({
    required this.label,
    required this.onChanged,
    super.key,
    this.value,
  });

  /// Label
  final String label;

  /// Selected value
  final GenderEnum? value;

  /// On changed
  final ValueChanged<GenderEnum> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(34.r),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.theme.inputDecorationTheme.labelStyle?.copyWith(fontSize: 35.sp),
          ),
          HSB(40.h),
          Row(
            children: [
              WSB(10.w),
              Expanded(
                child: FloatingActionButton.extended(
                  heroTag: 'female',
                  elevation: 0.5,
                  extendedIconLabelSpacing: 60.w,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.r),
                  ),
                  backgroundColor: GenderEnum.female == value
                      ? context.theme.colorScheme.primary
                      : Colors.white,
                  onPressed: () => onChanged(GenderEnum.female),
                  icon: AppSvgImage(
                    LibAssets.svgFemaleSign,
                    height: 65.h,
                    package: 'mobile_library',
                  ),
                  label: Text(
                    t.common.gender.value[GenderEnum.female.name] ?? GenderEnum.female.name,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 44.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(17, 22, 49, 1),
                      ),
                    ),
                  ),
                ),
              ),
              WSB(50.w),
              Expanded(
                child: FloatingActionButton.extended(
                  heroTag: 'male',
                  elevation: 0.5,
                  extendedIconLabelSpacing: 60.w,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.r),
                  ),
                  backgroundColor: GenderEnum.male == value
                      ? context.theme.colorScheme.primary
                      : Colors.white,
                  onPressed: () => onChanged(GenderEnum.male),
                  icon: AppSvgImage(LibAssets.svgMaleSign, height: 65.h, package: 'mobile_library'),
                  label: Text(
                    t.common.gender.value[GenderEnum.male.name] ?? GenderEnum.male.name,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 44.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(17, 22, 49, 1),
                      ),
                    ),
                  ),
                ),
              ),
              WSB(10.w),
            ],
          ),
          HSB(20.h),
        ],
      ),
    );
  }
}
