import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_library/mobile_library.dart';

part 'trip_location.freezed.dart';

/// Trip location for trip's Start and End
@freezed
abstract class TripLocation with _$TripLocation {
  /// Constructor
  const factory TripLocation({
    required String locationName,
    required DateTime timestamp,
    required LatLong latLong,
  }) = _TripLocation;

  @override
  String toString() =>
      '''
    TripLocation(
      locationName: $locationName,
      timestamp: $timestamp, 
      latLong: $latLong
    )
    ''';
}
