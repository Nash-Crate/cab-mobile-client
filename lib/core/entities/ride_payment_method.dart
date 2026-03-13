import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride_payment_method.freezed.dart';

/// Ride payment method
@freezed
class RidePaymentMethod with _$RidePaymentMethod {
  /// constructor
  const factory RidePaymentMethod() = _RidePaymentMethod;

  @override
  String toString() {
    return 'RidePaymentMethod()';
  }
}
