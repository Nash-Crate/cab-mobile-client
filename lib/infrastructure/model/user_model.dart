import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_client/core/entities/entities.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User model
@freezed
abstract class UserModel with _$UserModel {
  /// constructor
  const factory UserModel({
    required String id,
  }) = _UserModel;

  const UserModel._();

  /// Create user model from json
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Convert [UserModel] to [User] entity
  User toDomain() {
    return User(
      id: id,
    );
  }
}
