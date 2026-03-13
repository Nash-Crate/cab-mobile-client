import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_class.freezed.dart';

/// Vehicle class
@freezed
abstract class VehicleClass with _$VehicleClass {
  /// constructor
  const factory VehicleClass({
    required String id,
    required String name,
  }) = _VehicleClass;
}
