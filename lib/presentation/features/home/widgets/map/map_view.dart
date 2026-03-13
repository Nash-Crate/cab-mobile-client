import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';
import 'package:mobile_library/mobile_library.dart';

/// Home page map view
class HomeMapView extends StatelessWidget {
  /// constructor
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RideCubit, RideState>(
      builder: (context, state) {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: state.cameraPosition,
              onMapCreated: context.read<RideCubit>().initMapController,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: state.markers,
              polylines: state.polylines.values.toSet(),
            ),

            // overlay pins
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // pickup icon
                if (state.startLocation == null)
                  Center(
                    child: SizedBox(
                      width: 141.w,
                      height: 195.h * 2,
                      child: Stack(
                        children: [
                          SizedBox(width: 141.w, height: 195.h),
                          AppSvgImage(Assets.homePickup, width: 141.w, height: 195.h),
                        ],
                      ),
                    ),
                  )
                // pickup icon
                else if (!state.tripInitiated &&
                    state.endLocation == null &&
                    state.startLocation != null)
                  Center(
                    child: SizedBox(
                      width: 141.w,
                      height: 195.h * 2,
                      child: Stack(
                        children: [
                          SizedBox(width: 141.w, height: 195.h),
                          AppSvgImage(Assets.homeDropOff, width: 141.w, height: 195.h),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
