import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';
import 'package:mobile_library/mobile_library.dart';

/// Floating action buttons to set the drop off location or open rides
class DropOffFab extends StatelessWidget {
  /// constructor
  const DropOffFab({required this.onOpenRide, super.key});

  /// Callback to open rides
  final VoidCallback onOpenRide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 100.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: FloatingActionButton(
                    heroTag: 'pickup_location',
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(31.sp)),
                    elevation: 0.5,
                    backgroundColor: Colors.white,
                    onPressed: context.read<RideCubit>().setPickupLocation,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chevron_left,
                          color: Color.fromRGBO(139, 139, 139, 1),
                        ),
                        CircleAvatar(
                          backgroundColor: const Color.fromRGBO(255, 241, 200, 1),
                          child: AppSvgImage(Assets.home.pickupInvertedSmall.path),
                        ),
                        // WSB(20.w),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.home.actions.pickupLocation,
                                  style: context.textTheme.titleSmall,
                                ),
                                Text(
                                  // fixme: use the address from the state
                                  '10 Lorem, ipsum dolor set amet',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                WSB(20.w),
                Expanded(
                  child: FloatingActionButton(
                    heroTag: 'open_ride',
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(31.sp)),
                    elevation: 0,
                    backgroundColor: const Color.fromRGBO(229, 250, 237, 0.9),
                    onPressed: onOpenRide,
                    child: Text(
                      t.home.actions.openRide,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: const Color.fromRGBO(45, 54, 61, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
