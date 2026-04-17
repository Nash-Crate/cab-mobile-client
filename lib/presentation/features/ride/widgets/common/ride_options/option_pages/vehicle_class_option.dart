import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';
import 'package:mobile_library/mobile_library.dart';

/// Vehicle class option
class VehicleClassOption extends StatefulWidget {
  /// constructor
  const VehicleClassOption({super.key});

  @override
  State<VehicleClassOption> createState() => _VehicleClassOptionState();
}

class _VehicleClassOptionState extends State<VehicleClassOption> {
  int? _selected;

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t.ride.options.vehicleClass.title,
                    style: context.textTheme.headlineMedium,
                  ),
                ],
              ),
              HSB(50.h),
              Row(
                children: [
                  SelectionCard(
                    selection: _selected == null
                        ? SelectionState.idle
                        : _selected == 0
                        ? SelectionState.selected
                        : SelectionState.idle,
                    onSelection: (value) {
                      // TODO(value): implement
                      setState(() => _selected = 0);
                    },
                    padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
                    backgroundColor: const Color.fromRGBO(255, 243, 207, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.ride.options.vehicleClass.classes.standard,
                          style: context.textTheme.bodyMedium,
                        ),
                        HSB(10.sp),
                        Text(
                          '${250} MRU',
                          style: context.textTheme.bodyLarge,
                        ),
                        HSB(10.sp),
                        AppImage(Assets.home.trip.standardClassCarCropped.path),
                      ],
                    ),
                  ),
                  WSB(50.w),
                  SelectionCard(
                    selection: _selected == null
                        ? SelectionState.idle
                        : _selected == 1
                        ? SelectionState.selected
                        : SelectionState.idle,
                    onSelection: (value) {
                      // TODO(value): implement
                      setState(() => _selected = 1);
                    },
                    padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
                    backgroundColor: const Color.fromRGBO(229, 250, 237, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.ride.options.vehicleClass.classes.vip,
                          style: context.textTheme.bodyMedium,
                        ),
                        HSB(10.sp),
                        Text(
                          '${300} MRU',
                          style: context.textTheme.bodyLarge,
                        ),
                        HSB(10.sp),
                        AppImage(Assets.home.trip.vipClassCarCropped.path),
                      ],
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
                    onPressed: _selected == null
                        ? null
                        : () {
                            // TODO(value): implement
                            context.read<RideCubit>().onVehicleClassChanged(
                              const VehicleClass(id: '1', name: 'Car'),
                            );
                            context.flow<TripStateEnum>().update(
                              (_) => TripStateEnum.paymentMethodSelection,
                            );
                          },
                    child: Text(t.common.actions.cont),
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
