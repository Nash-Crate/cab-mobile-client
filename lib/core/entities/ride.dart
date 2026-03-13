import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_client/core/entities/entities.dart';
import 'package:mobile_library/mobile_library.dart';

part 'ride.freezed.dart';

/// Ride entity
@freezed
abstract class Ride with _$Ride {
  /// Constructor
  const factory Ride({
    required String id,
    required TripTypeEnum rideType,
    required DateTime timestamp,
    required double amount,
    required TripLocation start,
    required TripLocation end,
    required RideType rideClass,
    required RidePaymentMethod ridePaymentMethod,
  }) = _Ride;
}
