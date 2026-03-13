import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_library/mobile_library.dart';

/// Pick Up map marker
Future<BitmapDescriptor> get pickUpMapMarker async {
  return SizedBox(
    width: 141.w / 2.5,
    height: 195.h / 2.5,
    child: const AppSvgImage(Assets.homeDroppedPickup),
  ).toBitmapDescriptor();
}

/// Drop Off map marker
Future<BitmapDescriptor> get dropOffMapMarker async {
  return SizedBox(
    width: 141.w / 2.5,
    height: 195.h / 2.5,
    child: const AppSvgImage(Assets.homeDroppedDropOff),
  ).toBitmapDescriptor();
}

/// Drop Off map marker
Future<BitmapDescriptor> get driverMapMarker async {
  return SizedBox(
    width: 141.w / 2.5,
    height: 195.h / 2.5,
    child: const AppImage(Assets.rideDriver, fit: BoxFit.contain),
  ).toBitmapDescriptor();
}
