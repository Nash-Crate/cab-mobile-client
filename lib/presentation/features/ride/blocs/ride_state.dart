part of 'ride_cubit.dart';

/// RideState defines the state of the ride feature in the application.
enum TripStateEnum {
  /// vehicle class selection
  vehicleClassSelection,

  /// payment method selection
  paymentMethodSelection,

  /// trip details before initiating
  preTripDetails,

  /// trip initiated
  driverSearching,

  /// driver is on the way to pick up
  driverArriving,

  /// driver has arrived at the pickup location
  driverArrived,

  /// trip started
  tripOnTheWay,

  /// trip is completed
  tripCompleted,

  /// trip is concluded
  tripCancelled,
}

/// RideState holds the state of the ride feature, including markers, polylines, camera position, and trip details.
@freezed
abstract class RideState with _$RideState {
  /// Factory constructor for RideState
  const factory RideState({
    required Set<Marker> markers,
    required Map<PolylineId, Polyline> polylines,
    //
    required CameraPosition cameraPosition,
    @Default(false) bool positionProcessing,
    @Default(null) TripLocation? startLocation,
    @Default(null) TripLocation? endLocation,
    @Default(null) VehicleClass? vehicleClass,
    @Default(null) PayMethod? payMethod,
    @Default(null) TripDriver? driver,
    @Default(null) String? id,
    @Default(false) bool tripInitiated,
    @Default(false) bool driverArrived,
    @Default(false) bool tripStarted,
    @Default(false) bool tripCompleted,
    @Default(false) bool tripConcluded,
  }) = _RideState;

  /// Initial state of the RideState
  factory RideState.initial() {
    return const RideState(
      cameraPosition: CameraPosition(
        target: LatLng(37.42796133580664, -122.085749655962),
        zoom: 14.4746,
      ),
      markers: <Marker>{},
      polylines: <PolylineId, Polyline>{},
    );
  }
}
