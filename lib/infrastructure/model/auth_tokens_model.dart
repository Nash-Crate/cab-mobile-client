// JsonKey annotations for serialization
// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens_model.freezed.dart';
part 'auth_tokens_model.g.dart';

/// Login response model
@freezed
abstract class AuthTokensModel with _$AuthTokensModel {
  /// constructor
  const factory AuthTokensModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'expires_in') required int expiresIn,
    @JsonKey(name: 'refresh_expires_in') required int refreshExpiresIn,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'token_type') required String tokenType,
    @JsonKey(name: 'not-before-policy') required int notBeforePolicy,
    @JsonKey(name: 'session_state') required String sessionState,
    @JsonKey(name: 'scope') required String scope,
  }) = _AuthTokensModel;

  const AuthTokensModel._();

  /// constructor
  factory AuthTokensModel.fromJson(Map<String, dynamic> json) => _$AuthTokensModelFromJson(json);
}
