import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

part 'rider_login.freezed.dart';

/// Usecase for login a rider to the app
@singleton
class LoginRider implements Usecase<Unit, LoginRiderParams> {
  /// Constructor
  const LoginRider(this._authRepository);

  final IAuthRepository _authRepository;

  @override
  Future<Either<Failure, Unit>> call(LoginRiderParams params) {
    return _authRepository.riderLogin(params);
  }
}

/// Parameters for login a rider
@freezed
abstract class LoginRiderParams with _$LoginRiderParams {
  /// constructor
  const factory LoginRiderParams({
    required FullPhoneNumber phoneNumber,
    required VerificationCode code,
  }) = _LoginRiderParams;
}
