import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

/// Get user for the active accessToken usecase
@singleton
class GetUser implements UsecaseNoParams<User> {
  /// Constructor
  const GetUser(this._authRepository);

  final IAuthRepository _authRepository;

  @override
  Future<Either<Failure, User>> call() {
    return _authRepository.getUser();
  }
}
