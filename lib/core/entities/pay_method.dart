import 'package:freezed_annotation/freezed_annotation.dart';

part 'pay_method.freezed.dart';

/// Pay method
@freezed
abstract class PayMethod with _$PayMethod {
  /// constructor
  const factory PayMethod({
    required String id,
    required String name,
  }) = _PayMethod;
}
