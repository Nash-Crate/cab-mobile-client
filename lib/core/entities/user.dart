import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// User entity
@freezed
abstract class User with _$User {
  /// constructor
  const factory User({
    required String id,
  }) = _User;
}
