part of 'home_map_actions_cubit.dart';

/// HomeMapAction enum defines the actions that can be performed on the home map.
enum HomeMapAction {
  /// initial
  init,

  /// pick up a ride
  pickUp,

  /// drop off a ride
  dropOff,

  /// current location
  currentLocation,

  /// clear pick up
  clearPickUp,

  /// open ride
  openRide,
}

/// HomeMapActionsState defines the state of the home map actions.
@freezed
class HomeMapActionsState with _$HomeMapActionsState {
  /// Initial state of the home map actions.
  const factory HomeMapActionsState.initial() = _Initial;

  /// Processing state of the home map actions.
  const factory HomeMapActionsState.processing(HomeMapAction action) = HomeMapProcessing;

  /// Success state of the home map actions.
  const factory HomeMapActionsState.failure(HomeMapAction action, String error) = HomeMapFailure;
}
