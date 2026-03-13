import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';
import 'package:mobile_library/mobile_library.dart';

/// Pre trip details
class PreTripDetails extends StatelessWidget {
  /// constructor
  const PreTripDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    t.ride.options.yourTrip.title,
                    style: context.textTheme.headlineMedium,
                  ),
                ],
              ),
              HSB(50.h),
              const PickDropLocation(),
              HSB(50.h),
              Row(
                children: [
                  Expanded(
                    child: SelectedCard(
                      backgroundColor: const Color.fromRGBO(255, 243, 207, 1),
                      padding: EdgeInsets.all(30.sp).copyWith(right: 0),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 200.h,
                                width: 0.25.sw,
                                child: const AppImage(
                                  Assets.tripStandardClassCarCropped,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: SizedBox(width: 0.2.sw, child: const Text('Standard Class')),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: AppSvgImage(
                              Assets.commonArrow,
                              color: Colors.orange,
                              width: 60.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  WSB(30.w),
                  Expanded(
                    child: SelectedCard(
                      backgroundColor: const Color.fromRGBO(220, 255, 233, 1),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Cash'),
                                HSB(40.h),
                                AppSvgImage(Assets.commonArrow, width: 60.h),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200.h,
                            width: 0.25.sw,
                            child: const AppImage(Assets.tripPayMethodCash, fit: BoxFit.contain),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      context.read<RideCubit>().searchForDriver();
                      context.flow<TripStateEnum>().update((_) => TripStateEnum.driverSearching);
                    },
                    child: Text(t.ride.options.shared.actions.letsGo),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
