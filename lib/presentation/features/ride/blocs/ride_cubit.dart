import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/common/common.dart';
import 'package:mobile_client/presentation/extensions/extensions.dart';
import 'package:mobile_client/presentation/theme/theme.dart';
import 'package:mobile_library/mobile_library.dart';

part 'ride_cubit.freezed.dart';

part 'ride_state.dart';

/// markers
/// pickup marker key
const pickUpMarkerKey = 'pickUp';

/// drop off marker key
const dropOffMarkerKey = 'dropOff';

/// driver marker key
const driverMarkerKey = 'driver';

/// polylines
/// ride polyline key
const ridePolylineKey = 'ride';

/// driver polyline key
const driverPolylineKey = 'driver';

/// travelled polyline key
const travelledPolylineKey = 'travelled';

/// Cubit for ride state
@injectable
class RideCubit extends Cubit<RideState> {
  /// Constructor
  RideCubit(@factoryParam LatLong? currentPosition) : super(RideState.initial(currentPosition)) {
    if (currentPosition == null) unawaited(toCurrentLocation());
  }

  // package name and sha1 for using Google Maps Routes API on Android
  final _androidPackage = const String.fromEnvironment('ANDROID_PACKAGE');
  final _androidCert = const String.fromEnvironment('ANDROID_CERT_SHA1');

  late final GoogleMapController _controller;

  /// Clear ride
  void clearRide() {
    final currentPosition = state.cameraPosition;
    emit(RideState.initial(null).copyWith(cameraPosition: currentPosition));
  }

  /// Init map controller
  void initMapController(GoogleMapController controller) {
    _controller = controller;

    emit(state.copyWith(positionProcessing: true));
    unawaited(toCurrentLocation());
  }

  /// Called when vehicle class is changed
  void onVehicleClassChanged(VehicleClass vehicleClass) =>
      emit(state.copyWith(vehicleClass: vehicleClass));

  /// Called when payMethod is changed
  void onPayMethodChanged(PayMethod payMethod) => emit(state.copyWith(payMethod: payMethod));

  /// set pickup location
  Future<void> setPickupLocation() async {
    final location = await getCenter();
    final icon = await pickUpMapMarkerIcon;
    final marker = Marker(
      markerId: const MarkerId(pickUpMarkerKey),
      position: LatLng(location.latitude, location.longitude),
      // infoWindow: InfoWindow(title: _title, snippet: _detail),
      icon: icon,
    );

    emit(
      state.copyWith(
        markers: state.markers.addOrOverrideOne(marker),
        startLocation: TripLocation(
          latLong: location.toLocalLatLong,
          locationName: 'start',
          timestamp: DateTime.now(),
        ),
        endLocation: null,
      ),
    );
  }

  /// set drop off location
  Future<void> setDropOffLocation() async {
    emit(state.copyWith(tripInitiated: true));

    final location = await getCenter();
    final icon = await dropOffMapMarker;

    final marker = Marker(
      markerId: const MarkerId(dropOffMarkerKey),
      position: LatLng(location.latitude, location.longitude),
      // infoWindow: InfoWindow(title: _title, snippet: _detail),
      icon: icon,
    );

    final markers = state.markers.toSet();
    if (markers.length > 1) markers.removeLast();
    emit(
      state.copyWith(
        markers: markers.addOrOverrideOne(marker),
        endLocation: TripLocation(
          latLong: location.toLocalLatLong,
          locationName: 'end',
          timestamp: DateTime.now(),
        ),
      ),
    );

    if (state.startLocation != null && state.endLocation != null) {
      final pc = await getPolylineCoordinates(
        state.startLocation!.latLong,
        state.endLocation!.latLong,
      );

      displayPolylinesFromPoints(pc, polylineId: ridePolylineKey);

      // move camera to center of the route
      // await setCameraPosition(
      //   LatLong(
      //     latitude: location.latitude - 0.005,
      //     longitude: location.longitude,
      //   ),
      // );
    }
  }

  /// start open ride
  void startOpenRide() => emit(state.copyWith(tripInitiated: true));

  /// Called when search a driver is activated
  void searchForDriver() {
    Future.delayed(const Duration(seconds: 5), () {
      // TODO(temp): temp data
      const driver = TripDriver(
        id: '123',
        name: 'John Doe',
        imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        vehicle: Vehicle(
          id: '123',
          brand: 'Toyota',
          model: 'Corolla Altis',
          color: 'Black',
          licensePlate: 'PBX 2384',
          imageUrl:
              'https://imgcdn.zigwheels.ph/large/gallery/color/30/2077/toyota-corolla-altis-2019-color-836869.jpg',
        ),
        driverLocation: LatLong(latitude: 59.3467183, longitude: 18.0097756),
      );
      emit(state.copyWith(driver: driver));
    });
  }

  /// driver found
  Future<void> driverFound(LatLong driverLocation) async {
    // TODO(temp): mock moving position
    final coordinates = await getPolylineCoordinates(
      driverLocation,
      state.startLocation!.latLong,
    );

    // move the camera to the driver
    await setCameraPosition(driverLocation);

    // listen to driver's location
    mockMovingPosition(coordinates)
        .listen((location) async {
          final driverLocation = await location;
          final icon = await driverMapMarker;
          final marker = Marker(
            markerId: const MarkerId(driverMarkerKey),
            position: LatLng(driverLocation.latitude, driverLocation.longitude),
            // infoWindow: InfoWindow(title: _title, snippet: _detail),
            icon: icon,
          );

          emit(
            state.copyWith(
              markers: state.markers.addOrOverrideOne(marker),
              driver: state.driver?.copyWith(driverLocation: driverLocation.toLocalLatLong),
            ),
          );

          final start = driverLocation.toLocalLatLong;
          final end = state.startLocation?.latLong;

          if (end != null) {
            await getPolylineCoordinates(start, end).then(
              (pc) => displayPolylinesFromPoints(
                pc,
                color: kSecondary,
                polylineId: driverPolylineKey,
              ),
            );
          }
        })
        .onDone(() async {
          /// Driver arrived
          emit(state.copyWith(driverArrived: true));

          // TODO(temp): Ride started
          await Future.delayed(const Duration(seconds: 3), rideStarted);
        });
  }

  /// ride started
  Future<void> rideStarted() async {
    // set the current location as trip start location
    final currentLocation = await getCurrentLocation;
    emit(
      state.copyWith(
        tripStarted: true,
        markers: state.markers.removeById(pickUpMarkerKey),
        startLocation: state.startLocation?.copyWith(
          latLong: LatLong(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude,
          ),
        ),
      ),
    );

    // TODO(temp): mock moving position
    final coordinates = await getPolylineCoordinates(
      state.startLocation!.latLong,
      state.tripStarted && state.endLocation == null
          // open
          ? const LatLong(
              latitude: 59.385654249496206,
              longitude: 18.044762913207496,
            )
          : state.endLocation!.latLong,
    );

    mockMovingPosition(coordinates)
        .listen((location) async {
          final driverLocation = await location;

          // driver marker and location
          final icon = await driverMapMarker;
          final marker = Marker(
            markerId: const MarkerId(driverMarkerKey),
            position: LatLng(driverLocation.latitude, driverLocation.longitude),
            // infoWindow: InfoWindow(title: _title, snippet: _detail),
            icon: icon,
          );
          emit(
            state.copyWith(
              markers: state.markers.addOrOverrideOne(marker),
              driver: state.driver?.copyWith(driverLocation: driverLocation.toLocalLatLong),
            ),
          );

          final current = driverLocation.toLocalLatLong;
          final end = state.endLocation?.latLong;

          // add the new polyline from current to end
          if (end != null) {
            await getPolylineCoordinates(current, end).then(
              (pc) => displayPolylinesFromPoints(pc, polylineId: ridePolylineKey),
            );
          }

          // so far travelled polyline
          final travelledPoints = List<LatLng>.from(
            state.polylines[const PolylineId(travelledPolylineKey)]?.points ?? [],
          )..add(driverLocation);
          displayPolylinesFromPoints(
            travelledPoints,
            color: kPrimary.withValues(alpha: .5),
            polylineId: travelledPolylineKey,
          );
        })
        .onDone(() {
          /// trip completed
          emit(state.copyWith(tripCompleted: true));
        });
  }

  /// trip concluded
  void tripConcluded() => emit(state.copyWith(tripConcluded: true));

  /// get polyline coordinates
  Future<List<LatLng>> getPolylineCoordinates(
    LatLong start,
    LatLong end,
  ) async {
    // clearAllGroupNotifications(errorKey);

    final polylineCoordinates = <LatLng>[];
    final polylinePoints = PolylinePoints(
      // TODO(change): change to ios key when on ios
      apiKey: const String.fromEnvironment('GOOGLE_MAPS_API_KEY_ENVIRONMENT_VARIABLE_ANDROID'),
    );

    // final result = await polylinePoints.getRouteBetweenCoordinates(
    //   request: PolylineRequest(
    //     origin: PointLatLng(start.latitude, start.longitude),
    //     destination: PointLatLng(end.latitude, end.longitude),
    //     mode: TravelMode.driving,
    //     // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
    //   ),
    // );
    // Create Routes API request
    final request = RoutesApiRequest(
      origin: PointLatLng(start.latitude, start.longitude),
      destination: PointLatLng(end.latitude, end.longitude),
      // travelMode: TravelMode.driving,
      routingPreference: RoutingPreference.trafficAware,
      headers: {
        'X-Android-Package': _androidPackage,
        'X-Android-Cert': _androidCert,
      },
    );

    // Get route using Routes API
    final response = await polylinePoints.getRouteBetweenCoordinatesV2(request: request);

    // if (result.points.isNotEmpty) {
    //   for (final point in result.points) {
    //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    //   }
    // } else {
    //   addError(result.errorMessage ?? t.errors.location.noRouteFound);
    // }

    if (response.routes.isNotEmpty) {
      for (final route in response.routes) {
        // Access route information
        // ('Duration: ${route.durationMinutes} minutes');
        // ('Distance: ${route.distanceKm} km');

        // Get polyline points
        final points = route.polylinePoints ?? [];
        for (final point in points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
    } else {
      addError(response.errorMessage ?? t.errors.location.noRouteFound);
    }

    return polylineCoordinates;
  }

  /// get polyline coordinates
  void displayPolylinesFromPoints(
    List<LatLng> polylineCoordinates, {
    required String polylineId,
    Color color = kPrimary,
  }) {
    final id = PolylineId(polylineId);
    final polyline = Polyline(
      polylineId: id,
      color: color,
      points: polylineCoordinates,
      width: 5,
    );
    emit(
      state.copyWith(polylines: state.polylines.addOrOverride(id, polyline)),
    );
  }

  /// get map center
  Future<LatLng> getCenter() async {
    final visibleRegion = await _controller.getVisibleRegion();
    final centerLatLng = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) / 2,
    );

    return centerLatLng;
  }

  /// Move camera to a specific location
  Future<void> setCameraPosition(LatLong location) async {
    emit(state.copyWith(positionProcessing: true));

    final position = CameraPosition(
      target: LatLng(location.latitude, location.longitude),
      zoom: state.cameraZoom,
    );

    emit(state.copyWith(cameraPosition: position, positionProcessing: false));
    await _controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  /// Move camera to current location
  Future<void> toCurrentLocation() async {
    try {
      emit(state.copyWith(positionProcessing: true));

      final l = await getCurrentLocation;
      await setCameraPosition(LatLong(latitude: l.latitude, longitude: l.longitude));
    } on Exception {
      emit(state.copyWith(positionProcessing: false));
      addError(t.errors.location.permissionsDenied);
    }
  }

  /// set camera zoom
  void setCameraZoom(double zoom) => emit(state.copyWith(cameraZoom: zoom));
}

/// Home map cubit extension
extension HomeMapCubitSetX on Set<Marker>? {
  /// add or override map marker
  Set<Marker> addOrOverrideOne(Marker marker) {
    final markers = this?.toSet()
      ?..removeWhere((m) => m.markerId == marker.markerId)
      ..add(marker);
    return markers ?? {};
  }

  /// remove last marker
  Set<Marker> removeLast() {
    final markers = this?.toSet();
    markers?.remove(markers.last);
    return markers ?? {};
  }

  /// remove by id
  Set<Marker> removeById(String id) {
    final markers = this?.toSet();
    markers?.removeWhere((m) => m.markerId.value == id);
    return markers ?? {};
  }
}

/// Home map cubit extension
extension HomeMapCubitMapX on Map<PolylineId, Polyline> {
  /// add a polyline
  Map<PolylineId, Polyline> addOne(PolylineId id, Polyline polyline) {
    return Map<PolylineId, Polyline>.from(this)..addEntries({id: polyline}.entries);
  }

  /// add or override driver polyline
  Map<PolylineId, Polyline> addOrOverride(PolylineId id, Polyline polyline) {
    return Map<PolylineId, Polyline>.from(this)
      ..removeWhere((pid, _) => pid == id)
      ..addEntries({id: polyline}.entries);
  }

  /// remove polyline
  Map<PolylineId, Polyline> removeOne(PolylineId id) {
    return Map<PolylineId, Polyline>.from(this)..removeWhere((pid, _) => pid == id);
  }

  /// keep Only polyline
  Map<PolylineId, Polyline> keepOnly(PolylineId? id) {
    return Map<PolylineId, Polyline>.from(this)..removeWhere((pid, _) => id == null || pid != id);
  }
}

/// moving location TODO(mock): mock moving location
Stream<Future<LatLng>> mockMovingPosition(List<LatLng> coordinates) {
  return Stream.periodic(const Duration(milliseconds: 300), (count) async {
    return coordinates[count % coordinates.length];
  }).take(coordinates.length);
}
