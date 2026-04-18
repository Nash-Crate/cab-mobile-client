import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_library/mobile_library.dart';

/// Pick Up map marker
Future<BitmapDescriptor> get pickUpMapMarkerIcon async {
  return SizedBox(
    width: 25.w,
    height: 25.h,
    child: AppSvgImage(Assets.home.droppedPickup.path),
  ).toBitmapDescriptor();
}

/// Drop Off map marker
Future<BitmapDescriptor> get dropOffMapMarker async {
  return SizedBox(
    width: 35.w,
    height: 35.h,
    child: AppSvgImage(Assets.home.droppedDropOff.path),
  ).toBitmapDescriptor();
}

/// Drop Off map marker
Future<BitmapDescriptor> get driverMapMarker async {
  return SizedBox(
    width: 100.w,
    height: 100.h,
    child: AppImage(Assets.ride.driver.path, fit: BoxFit.contain),
  ).toBitmapDescriptor();
}
