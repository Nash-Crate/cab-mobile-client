import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_ride_dto.freezed.dart';

/// New ride dto
@freezed
abstract class NewRideDto with _$NewRideDto {
  /// constructor
  const factory NewRideDto({
    String? name,
  }) = _NewRideDto;

  const NewRideDto._();

  /// check if dto is valid
  bool isValid() {
    return name != null;
  }
}
