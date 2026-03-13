import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/ride/blocs/blocs.dart';
import 'package:mobile_client/presentation/theme/theme.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip completed widget
class TripCompleted extends StatelessWidget {
  /// constructor
  const TripCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RideCubit, RideState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HSB(50.h),
                  AppSvgImage(Assets.rideMapArrived, width: .3.sw),
                  HSB(100.h),
                  SizedBox(
                    width: 0.6.sw,
                    child: Text(
                      t.ride.options.complete.title,
                      style: context.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  HSB(100.h),
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
                        child: Text(t.ride.options.complete.actions.back),
                      ),
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
