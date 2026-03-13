import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_client/core/core.dart';

part 'trip_details.freezed.dart';

/// Trip details
@freezed
abstract class TripDetails with _$TripDetails {
  /// constructor
  const factory TripDetails({
    required String id,
    required DateTime timestamp,
    required double amount,
    required TripLocation start,
    required TripLocation end,
    required VehicleClass vehicleClass,
    required PayMethod payMethod,
    required TripDriver driver,
  }) = _TripDetails;
}
