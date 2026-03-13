import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

/// Usecase for login check otp
///
/// returns 'true' if user exists
@singleton
class RequestLoginCheckOtp implements Usecase<bool, FullPhoneNumber> {
  /// Constructor
  const RequestLoginCheckOtp(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, bool>> call(FullPhoneNumber phoneNumber) {
    return _repository.requestLoginCheckOtp(phoneNumber);
  }
}
