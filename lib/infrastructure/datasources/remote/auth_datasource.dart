import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_client/infrastructure/infrastructure.dart';
import 'package:mobile_library/mobile_library.dart';

/// Remote datasource abstract interface for authentication
abstract class AuthRemoteDatasource {
  /// Send a login check otp
  ///
  /// returns 'true' if user exists
  Future<Either<Failure, bool>> requestLoginCheckOtp(
    FullPhoneNumber phoneNumber,
  );

  /// Send a rider login request to the server
  Future<Either<Failure, AuthTokensModel>> riderLogin(LoginRiderParams params);

  /// Send a logout request to the server
  Future<Either<Failure, Unit>> logout(String refreshToken);

  /// Send a rider signup request to the server
  Future<Either<Failure, Unit>> riderSignUp(RiderSignUpParams params);

  /// Get the current user
  Future<Either<Failure, User>> getUser();

  /// Refresh token
  Future<Either<Failure, AuthTokensModel>> refreshToken(String refreshToken);
}

/// Remote datasource implementation for authentication
@Singleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  /// constructor
  const AuthRemoteDatasourceImpl(this._client);

  final IHttpClient _client;

  @override
  Future<Either<Failure, bool>> requestLoginCheckOtp(
    FullPhoneNumber phoneNumber,
  ) async {
    try {
      final data = {'username': phoneNumber.getOrCrash};

      final res = await _client.post(loginCheckOtpUrl, data: data);
      return Right(res.statusCode.isOk);
    } on Exception catch (e) {
      if (e is DioException && e.response != null && e.response!.statusCode.isBadRequest) {
        // TODO(serverBug): no way to distinct between user not found and bad request
        // not user found
        return const Right(false);
      }

      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, AuthTokensModel>> riderLogin(
    LoginRiderParams params,
  ) async {
    try {
      final data = {
        'grant_type': 'password',
        'client_id': 'rider',
        'username': params.phoneNumber.getOrCrash,
        'password': params.code.getOrCrash,
      };

      final res = await _client.post(
        loginUserUrl,
        data: data,
        requestType: RequestContentType.formEncoded,
      );

      final tokens = AuthTokensModel.fromJson(res.data);

      return Right(tokens);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> riderSignUp(RiderSignUpParams params) async {
    try {
      final data = {
        'first_name': params.firstName.getOrCrash,
        'last_name': params.lastName.getOrCrash,
        'phoneNumber': params.phoneNumber.getOrCrash,
      };

      await _client.post(registerUserUrl, data: data);

      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final res = await _client.get(retrieveUserUrl);
      // TODO(fix): change url and response
      final user = UserModel.fromJson({'id': res.data['data']}).toDomain();

      return Right(user);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout(String refreshToken) async {
    try {
      final data = {
        'client_id': 'rider',
        'refresh_token': refreshToken,
      };

      await _client.post(
        logoutUserUrl,
        data: data,
        requestType: RequestContentType.formEncoded,
      );

      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, AuthTokensModel>> refreshToken(
    String refreshToken,
  ) async {
    try {
      final data = {
        'grant_type': 'refresh_token',
        'client_id': 'rider',
        'refresh_token': refreshToken,
      };

      final res = await _client.post(
        loginUserUrl,
        data: data,
        requestType: RequestContentType.formEncoded,
      );

      final tokens = AuthTokensModel.fromJson(res.data);

      return Right(tokens);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
