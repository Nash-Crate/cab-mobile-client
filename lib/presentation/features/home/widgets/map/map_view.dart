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
              onCameraMove: (position) {
                if (state.cameraZoom != position.zoom) {
                  context.read<RideCubit>().setCameraZoom(position.zoom);
                }
              },
            ),

            // overlay pins
            Stack(
              alignment: Alignment.center,
              children: [
                // pickup icon
                if (state.startLocation == null)
                  Center(
                    child: SizedBox(
                      width: 200.w,
                      height: 260.h,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 200.w,
                            height: 260.h,
                            // DEBUG-ONLY child: ColoredBox(color: Colors.green.withValues(alpha: .3)),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: AppSvgImage(
                              Assets.home.pickup.path,
                              // width: 100.w,
                              height: 100.h,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
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
                      width: 200.w,
                      height: 300.h,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 200.w,
                            height: 300.h,
                            // DEBUG-ONLY child: ColoredBox(color: Colors.red.withValues(alpha: .3)),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: AppSvgImage(
                              Assets.home.dropOff.path,
                              // width: 100.w,
                              height: 100.h,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
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
