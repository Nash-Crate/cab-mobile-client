import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';

/// Vehicle entity
@freezed
abstract class Vehicle with _$Vehicle {
  /// constructor
  const factory Vehicle({
    required String id,
    required String brand,
    required String model,
    required String color,
    required String licensePlate,
    String? imageUrl,
  }) = _Vehicle;
}
