part of 'trip_history_cubit.dart';

/// State for trip history
@freezed
abstract class TripHistoryState with _$TripHistoryState {
  /// Constructor
  const factory TripHistoryState({
    @Default([]) List<Trip> trips,
    @Default(0) int totalTrips,
    @Default(0) int page,
    @Default(0) int totalPages,
    @Default(false) bool hasMore,
    @Default(TripHistorySortByEnum.latest) TripHistorySortByEnum sortBy,
    @Default(false) bool processing,
    String? error,
  }) = _TripHistoryState;

  /// Initial state
  factory TripHistoryState.initial() => const TripHistoryState();
}
