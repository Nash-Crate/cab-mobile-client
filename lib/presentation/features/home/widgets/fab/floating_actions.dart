import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/home/home.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';
import 'package:mobile_library/mobile_library.dart';

/// Floating action button for home page
class HomeFloatingActions extends StatelessWidget {
  /// constructor
  const HomeFloatingActions({super.key});

  /// Start the ride
  Future<void> startTheRide(BuildContext context) async {
    showBottomSheet(
      context: context,
      enableDrag: false,
      builder: (context) {
        return BlocListener<RideCubit, RideState>(
          listenWhen: (previous, current) => previous.tripConcluded != current.tripConcluded,
          listener: (_, state) {
            if (state.tripConcluded) {
              Navigator.pop(context);
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              color: Colors.white,
              width: double.infinity,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RideOptions(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RideCubit, RideState>(
      builder: (context, state) {
        // Remove FAB actions on [RideMode] selection
        if (state.tripInitiated) return const SizedBox.shrink();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // top
            AnimatedCrossFade(
              duration: crossFadeDuration * .5,
              firstChild: DropOffFab(
                onOpenRide: () {
                  context.read<RideCubit>().startOpenRide();
                  startTheRide(context);
                },
              ),
              secondChild: const CurrentPositionFab(),
              crossFadeState: state.startLocation != null
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),

            // bottom
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: AnimatedCrossFade(
                duration: crossFadeDuration,
                firstChild: HomeExtendedFab(
                  fillColor: context.colorScheme.secondary,
                  iconPath: Assets.homePickupInverted,
                  label: t.home.actions.begin,
                  onPressed: context.read<RideCubit>().setPickupLocation,
                ),
                secondChild: HomeExtendedFab(
                  fillColor: context.colorScheme.primary,
                  iconPath: Assets.homeDropOffInverted,
                  label: t.home.actions.setDropOff,
                  onPressed: () {
                    context.read<RideCubit>().setDropOffLocation();
                    startTheRide(context);
                  },
                ),
                crossFadeState: state.startLocation != null
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ),
          ],
        );
      },
    );
  }
}
