import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';
import 'package:mobile_library/mobile_library.dart';

final TextStyle _style = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: Colors.black,
    fontSize: 42.sp,
    fontWeight: FontWeight.w400,
  ),
);

/// Trip Details Routes data
class TripDetailsRoutes extends StatelessWidget {
  /// constructor
  const TripDetailsRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripHistoryDetailsCubit, TripHistoryDetailsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          margin: EdgeInsets.symmetric(horizontal: 80.w),
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
                            state.trip.start.locationName,
                            overflow: TextOverflow.ellipsis,
                            style: _style,
                            maxLines: 3,
                          ),
                        ),
                        WSB(20.w),
                        Text(DateFormat('HH:mm').format(state.trip.start.timestamp)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: SizedBox(
                        height: 60.h,
                        child: Divider(
                          thickness: 1.sp,
                          color: const Color.fromRGBO(204, 222, 211, 1),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            state.trip.end.locationName,
                            overflow: TextOverflow.ellipsis,
                            style: _style,
                            maxLines: 3,
                          ),
                        ),
                        WSB(20.w),
                        Text(DateFormat('HH:mm').format(state.trip.end.timestamp)),
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
                child: AppSvgImage(Assets.tripHistory.pickUp.path, width: 72.w, height: 72.h),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: 72.w,
                  child: AppSvgImage(Assets.tripHistory.dropOff.path, width: 54.w, height: 77.h),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
