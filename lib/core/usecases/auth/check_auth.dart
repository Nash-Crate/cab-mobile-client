import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

/// Usecase for check previous authentications
@singleton
class CheckAuth implements UsecaseNoParams<bool> {
  /// Constructor
  const CheckAuth(this._authRepository);

  final IAuthRepository _authRepository;

  @override
  Future<Either<Failure, bool>> call() {
    return _authRepository.checkAuth();
  }
}
