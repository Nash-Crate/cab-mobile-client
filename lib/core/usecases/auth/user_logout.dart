import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

/// Usecase for user logout
@singleton
class UserLogout implements UsecaseNoParams<Unit> {
  /// Constructor
  const UserLogout(this._authRepository);

  final IAuthRepository _authRepository;

  @override
  Future<Either<Failure, Unit>> call() {
    return _authRepository.logout();
  }
}
