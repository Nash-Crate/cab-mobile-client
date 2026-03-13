import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/infrastructure/infrastructure.dart';
import 'package:mobile_library/mobile_library.dart';

/// Local datasource abstract interface for authentication
abstract class AuthLocalDatasource {
  /// Check if previous auth tokens exists
  Future<Either<Failure, bool>> checkAuth();

  /// Cache token in local storage
  Future<Either<Failure, Unit>> cacheTokens(AuthTokensModel? tokens);

  /// Get token from local storage
  Future<Either<Failure, AuthTokensModel?>> getToken();

  /// Validate given access token
  Either<Failure, bool> validateToken(String accessToken);
}

/// Local datasource implementation for authentication
@Singleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl extends AuthLocalDatasource {
  /// Constructor
  AuthLocalDatasourceImpl(this._cacheStorage);

  final ICacheStorage _cacheStorage;

  @override
  Future<Either<Failure, bool>> checkAuth() async {
    try {
      final result =
          await _cacheStorage.read<String>(key: CacheKeys.token.name);
      return Right(result != null);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> cacheTokens(AuthTokensModel? tokens) async {
    try {
      // delete tokens if null is passed
      if (tokens == null) {
        await _cacheStorage.delete(key: CacheKeys.token.name);
        return const Right(unit);
      }

      final tokensString = jsonEncode(tokens.toJson());
      await _cacheStorage.upsert<String>(
        key: CacheKeys.token.name,
        data: tokensString,
      );
      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, AuthTokensModel?>> getToken() async {
    try {
      final result =
          await _cacheStorage.read<String>(key: CacheKeys.token.name);
      if (result != null) {
        final tokensMap = jsonDecode(result) as Map<String, dynamic>;
        return Right(AuthTokensModel.fromJson(tokensMap));
      }

      return const Right(null);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Either<Failure, bool> validateToken(String accessToken) {
    try {
      final isExpired = JwtDecoder.isExpired(accessToken);
      if (isExpired) {
        return const Left(Failure.authFailure(AuthFailure.tokenExpired()));
      }
      return const Right(false);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
