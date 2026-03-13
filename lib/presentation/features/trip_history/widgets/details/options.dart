import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

/// Trip details options such as class and payment method
class TripDetailsOptions extends StatelessWidget {
  /// constructor
  const TripDetailsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripHistoryDetailsCubit, TripHistoryDetailsState>(
      builder: (context, state) {
        if (state.processing) {
          // TODO(processing): processing ui
          return const Center(child: CircularProgressIndicator());
        } else if (state.details == null) {
          // TODO(error): error ui
          return const Center(child: Text('Error'));
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 80.w, vertical: 40.h),
          child: Row(
            children: [
              // class
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(246, 246, 246, 1),
                    borderRadius: BorderRadius.all(Radius.circular(13.r)),
                  ),
                  child: SizedBox(
                    height: 160.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 40.w, right: 20.w),
                            child: Text(
                              state.details!.vehicleClass.name,
                              style: _style,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 120.h,
                            child: const AppImage(Assets.tripStandardClassCarCropped),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              WSB(40.w),

              // payment method
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(246, 246, 246, 1),
                    borderRadius: BorderRadius.all(Radius.circular(13.r)),
                  ),
                  child: SizedBox(
                    height: 160.h,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 20.w,
                          child: SizedBox(
                            width: 158.w,
                            height: 179.h,
                            child: const AppImage(Assets.tripPayMethodCash, fit: BoxFit.contain),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 40.w, top: 20.h, right: 20.w),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payment Method',
                                    style: _style.copyWith(
                                      fontSize: 26.sp,
                                      color: const Color.fromRGBO(104, 104, 104, 1),
                                    ),
                                  ),
                                  HSB(10.h),
                                  Text(state.details!.payMethod.name, style: _style),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
