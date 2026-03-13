import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip details driver
class TripDetailsDriver extends StatelessWidget {
  /// constructor
  const TripDetailsDriver({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Driver',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: const Color.fromRGBO(184, 184, 184, 1),
                    fontSize: 52.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Divider(
                thickness: 2.sp,
                color: const Color.fromRGBO(192, 207, 223, 1),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 40.h),
                child: Row(
                  children: [
                    if (state.details?.driver.imageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(24.r)),
                        child: CachedNetworkImage(
                          imageUrl: state.details!.driver.imageUrl!,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    if (state.details?.driver.imageUrl != null) WSB(40.w),
                    Text(
                      state.details!.driver.name,
                      maxLines: 3,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 57.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                margin: EdgeInsets.symmetric(vertical: 40.h),
                padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 40.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.details!.driver.vehicle.brand} ${state.details!.driver.vehicle.model}',
                            maxLines: 3,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 46.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          HSB(30.h),
                          Text(
                            '${state.details!.driver.vehicle.color} • ${state.details!.driver.vehicle.licensePlate}',
                            maxLines: 3,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: const Color.fromRGBO(121, 122, 132, 1),
                                fontSize: 36.5.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.details!.driver.vehicle.imageUrl != null)
                      AppImage(
                        state.details!.driver.vehicle.imageUrl!,
                        height: 220.h,
                        width: 500.w,
                        fit: BoxFit.fitHeight,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
