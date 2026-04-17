import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_library/mobile_library.dart';

/// Pick drop location
class PickDropLocation extends StatelessWidget {
  /// constructor
  const PickDropLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.sp, horizontal: 40.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.sp),
        color: const Color.fromRGBO(250, 250, 250, 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSvgImage(Assets.ride.tripPickupLocation.path, width: 100.w, height: 100.h),
              WSB(50.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.ride.options.shared.pickUp,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: const Color.fromRGBO(152, 152, 152, 1),
                          fontSize: 41.sp,
                        ),
                      ),
                    ),
                    HSB(10.h),
                    Text(
                      '10 Lorem, ipsum dolor set amet, ipsum dolor set amet',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 46.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50.w),
                child: AppSvgImage(Assets.ride.pencil.path, width: 100.w),
              ),
            ],
          ),
          Divider(thickness: 0.2, indent: 130.w, endIndent: 20.w, height: 100.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSvgImage(Assets.ride.tripDropOffLocation.path, width: 100.w, height: 100.h),
              WSB(50.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.ride.options.shared.dropOff,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: const Color.fromRGBO(152, 152, 152, 1),
                          fontSize: 41.sp,
                        ),
                      ),
                    ),
                    HSB(10.h),
                    Text(
                      '20 Lorem, ipsum dolor set amet, ipsum dolor set amet',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 46.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50.w),
                child: AppSvgImage(
                  Assets.ride.pencil.path,
                  color: context.colorScheme.primary,
                  width: 100.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
