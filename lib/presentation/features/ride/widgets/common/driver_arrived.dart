import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';
import 'package:mobile_library/mobile_library.dart';

/// Driver arrived
class DriverArrived extends StatelessWidget {
  /// constructor
  const DriverArrived({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideCubit, RideState>(
      listenWhen: (m, n) => m.tripStarted != n.tripStarted,
      listener: (context, state) {
        if (state.tripStarted) {
          context.flow<TripStateEnum>().update((_) => TripStateEnum.tripOnTheWay);
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DriverCarInfo(
              title: t.ride.options.arrived.title,
              subTitle: t.ride.options.arrived.subtitle,
              vehicle: context.read<RideCubit>().state.driver!.vehicle,
            ),
            Divider(thickness: 0.2, height: 100.h),
            const RideDriverContact(),
          ],
        );
      },
    );
  }
}
