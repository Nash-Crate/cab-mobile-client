import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_library/mobile_library.dart';

final TextStyle _style = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: Colors.black,
    fontSize: 42.sp,
    fontWeight: FontWeight.w400,
  ),
);

/// Trip history card body
class TripHistoryCardBody extends StatelessWidget {
  /// constructor
  const TripHistoryCardBody(this.trip, {super.key});

  /// Trip
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 40.w),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 100.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        trip.start.locationName,
                        overflow: TextOverflow.ellipsis,
                        style: _style,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: SizedBox(
                    height: 60.h,
                    child: Divider(thickness: 1.sp, color: const Color.fromRGBO(204, 222, 211, 1)),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        trip.end.locationName,
                        overflow: TextOverflow.ellipsis,
                        style: _style,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 36.w,
            bottom: 0,
            child: Container(
              width: 2.8.w,
              color: const Color.fromRGBO(236, 236, 236, 1),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: AppSvgImage(Assets.tripHistoryPickUp, width: 72.w, height: 72.h),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: 72.w,
              child: AppSvgImage(Assets.tripHistoryDropOff, width: 54.w, height: 77.h),
            ),
          ),
        ],
      ),
    );
  }
}
