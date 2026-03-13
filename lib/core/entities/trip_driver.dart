import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

part 'trip_driver.freezed.dart';

/// Trip driver
@freezed
abstract class TripDriver with _$TripDriver {
  /// Constructor
  const factory TripDriver({
    required String id,
    required LatLong driverLocation,
    required String name,
    required Vehicle vehicle,
    String? imageUrl,
  }) = _TripDriver;
}
