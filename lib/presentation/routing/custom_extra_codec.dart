part of 'router.dart';

/// A codec that can serialize custom data.
class CustomExtraCodec extends Codec<Object?, Object?> {
  /// Create a codec.
  const CustomExtraCodec();
  @override
  Converter<Object?, Object?> get decoder => const _CustomExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _CustomExtraEncoder();
}

class _CustomExtraDecoder extends Converter<Object?, Object?> {
  const _CustomExtraDecoder();
  @override
  Object? convert(Object? input) {
    if (input == null) return null;

    final inputAsList = input as List<Object?>;
    if (inputAsList[0] == 'TripDetailsRouteExtra') {
      return TripDetailsRouteExtra(
        id: inputAsList[1]! as String,
        tripType: inputAsList[2]! as TripTypeEnum,
        timestamp: inputAsList[3]! as DateTime,
        amount: inputAsList[4]! as double,
        start: inputAsList[5]! as TripLocation,
        end: inputAsList[6]! as TripLocation,
        rideType: inputAsList[7]! as RideType,
        ridePaymentMethod: inputAsList[8]! as RidePaymentMethod,
      );
    }

    throw FormatException('Unable to parse input: $input');
  }
}

class _CustomExtraEncoder extends Converter<Object?, Object?> {
  const _CustomExtraEncoder();
  @override
  Object? convert(Object? input) {
    if (input == null) return null;

    switch (input) {
      case TripDetailsRouteExtra _:
        return <Object?>['TripDetailsRouteExtra', input.id];
      default:
        throw FormatException('Cannot encode type ${input.runtimeType}');
    }
  }
}
