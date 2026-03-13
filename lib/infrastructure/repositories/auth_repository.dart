import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_client/infrastructure/infrastructure.dart';
import 'package:mobile_library/mobile_library.dart';

/// implementation of the IAuthRepository
@Singleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  /// constructor
  const AuthRepository(this._remoteDatasource, this._localDatasource);

  final AuthRemoteDatasource _remoteDatasource;
  final AuthLocalDatasource _localDatasource;

  @override
  Future<Either<Failure, bool>> requestLoginCheckOtp(FullPhoneNumber phoneNumber) {
    return _remoteDatasource.requestLoginCheckOtp(phoneNumber);
  }

  @override
  Future<Either<Failure, Unit>> riderLogin(LoginRiderParams params) async {
    final result = await _remoteDatasource.riderLogin(params);
    if (result.isRight()) {
      // cache token
      await _localDatasource.cacheTokens(result.asR);
      return const Right(unit);
    }
    return Left(result.asL);
  }

  @override
  Future<Either<Failure, Unit>> riderSignUp(RiderSignUpParams params) {
    return _remoteDatasource.riderSignUp(params);
  }

  @override
  Future<Either<Failure, bool>> checkAuth() {
    return _localDatasource.checkAuth();
  }

  @override
  Future<Either<Failure, User>> getUser() {
    return _remoteDatasource.getUser();
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    final tokens = await _localDatasource.getToken();
    if (tokens.isLeft()) return Left(tokens.asL);

    if (tokens.asR == null) return const Right(unit);

    await _localDatasource.cacheTokens(null);
    return _remoteDatasource.logout(tokens.asR!.refreshToken);
  }
}
