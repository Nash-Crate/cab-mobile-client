import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';
import 'package:mobile_client/presentation/theme/theme.dart';
import 'package:mobile_library/mobile_library.dart';

/// Driver searching
class DriverSearching extends StatelessWidget {
  /// constructor
  const DriverSearching({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RideCubit, RideState>(
      listener: (context, state) {
        if (state.driver != null) {
          context.read<RideCubit>().driverFound(state.driver!.driverLocation);
          context.flow<TripStateEnum>().update((_) => TripStateEnum.driverArriving);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HSB(50.h),
                AppSvgImage(Assets.rideMapMagnifier, width: .3.sw),
                HSB(50.h),
                Text(
                  t.ride.options.lookingForDriver.title,
                  style: context.textTheme.headlineMedium,
                ),
                HSB(20.h),
                Text(
                  t.ride.options.lookingForDriver.subtitle,
                ),
                Divider(thickness: 0.2, height: 100.h),
                const PickDropLocation(),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () => context.read<RideCubit>()
                        ..clearRide()
                        ..tripConcluded(),
                      style: context.theme.filledButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStateProperty.all(kDisabledBg),
                        foregroundColor: WidgetStateProperty.all(Colors.black),
                      ),
                      child: Text(t.common.actions.cancel),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
