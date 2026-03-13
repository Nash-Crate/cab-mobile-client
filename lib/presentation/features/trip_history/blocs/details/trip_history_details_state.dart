part of 'trip_history_details_cubit.dart';

/// Trip history details state
@freezed
abstract class TripHistoryDetailsState with _$TripHistoryDetailsState {
  /// Constructor
  const factory TripHistoryDetailsState({
    required Trip trip,
    TripDetails? details,
    @Default(true) bool processing,
    String? error,
  }) = _TripHistoryDetailsState;

  /// Initial state
  factory TripHistoryDetailsState.initial(Trip trip) => TripHistoryDetailsState(trip: trip);
}
