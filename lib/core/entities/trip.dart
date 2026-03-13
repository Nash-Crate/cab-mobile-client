import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

part 'trip.freezed.dart';

/// Trip entity
@freezed
abstract class Trip with _$Trip {
  /// Constructor
  const factory Trip({
    required String id,
    required TripTypeEnum tripType,
    required DateTime timestamp,
    required double amount,
    required TripLocation start,
    required TripLocation end,
    required RideType rideType,
    required RidePaymentMethod ridePaymentMethod,
  }) = _Trip;
}
