import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';
import 'package:mobile_client/presentation/theme/theme.dart';
import 'package:mobile_library/mobile_library.dart';

/// Driver arriving
class DriverArriving extends StatelessWidget {
  /// constructor
  const DriverArriving({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RideCubit, RideState>(
      listenWhen: (m, n) => m.driverArrived != n.driverArrived,
      listener: (context, state) {
        if (state.driverArrived) {
          context.flow<TripStateEnum>().update((_) => TripStateEnum.driverArrived);
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
                DriverCarInfo(
                  title: t.ride.options.arriving.title,
                  vehicle: context.read<RideCubit>().state.driver!.vehicle,
                ),
                Divider(thickness: 0.2, height: 100.h),
                const RideDriverContact(),
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
