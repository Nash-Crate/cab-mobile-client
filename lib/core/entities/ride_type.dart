import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride_type.freezed.dart';

/// Ride type
@freezed
class RideType with _$RideType {
  /// constructor
  const factory RideType() = _RideType;

  @override
  String toString() {
    return 'RideType()';
  }
}
