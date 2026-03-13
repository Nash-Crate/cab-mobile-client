import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/infrastructure/infrastructure.dart';
import 'package:mobile_client/presentation/extensions/extensions.dart';
import 'package:mobile_library/mobile_library.dart';

/// will bypass accessToken check on these urls
const List<String> noneAuthedRoute = [
  loginCheckOtpUrl,
  loginUserUrl,
  registerUserUrl,
  logoutUserUrl,
];

/// Dio http client interceptor override
@singleton
class DioInterceptor extends Interceptor {
  /// Constructor
  const DioInterceptor(this._authLocalDatasource, this._authRemoteDatasource);

  final AuthLocalDatasource _authLocalDatasource;
  final AuthRemoteDatasource _authRemoteDatasource;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // check if the [accessToken] is already appended to the headers
    final hasAccessToken =
        options.headers.containsKey('Authorization') && options.headers['Authorization'] != null;

    final mustHaveAuth = !noneAuthedRoute.any((x) => options.path == x);
    if (mustHaveAuth && !hasAccessToken) {
      final exception = DioException(requestOptions: options);

      final cachedUserEither = await _authLocalDatasource.getToken();
      if (cachedUserEither.isLeft()) {
        // on failure to retrieve the cache from the device
        return handler.reject(
          exception.copyWith(
            error: cachedUserEither.asL.message,
            message: cachedUserEither.asL.message,
          ),
        );
      }

      var tokens = cachedUserEither.asR;

      // when [refreshToken] doesn't exist in the cache, reject the request
      if (cachedUserEither.asR == null) {
        final errorMessage = const Failure.authFailure(NoPreviousAuth()).message;
        return handler.reject(
          exception.copyWith(
            error: DioUnknownErrorEnum.noPreviousAuth,
            message: errorMessage,
          ),
        );
      }

      if (tokens != null && JwtDecoder.isExpired(tokens.accessToken)) {
        var errorMessage = const Failure.authFailure(AuthFailure.tokenExpired()).message;

        // accessToken has expired, refresh it
        final refreshEither = await _authRemoteDatasource.refreshToken(
          cachedUserEither.asR!.refreshToken,
        );

        // if refresh failed for the [authTokens], reject the request
        if (refreshEither.isLeft()) {
          if (switch (refreshEither.asL) {
            TokenExpired() => true,
            NoPreviousAuth() => false,
            ValidationFailed() => false,

            // case AuthFailure.noPreviousAuth():
            // errorMessage = const Failure.authFailure(NoPreviousAuth()).message;
            // return handler.reject(
            // exception.copyWith(error: DioUnknownErrorEnum.noPreviousAuth, message: errorMessage),
            // );
            // case AuthFailure.tokenExpired():
            // errorMessage = const Failure.authFailure(AuthFailure.tokenExpired()).message;
            // break;
            // default:
            // errorMessage = refreshEither.asL.message;
            // TODO(fix): Handle this case.
            Failure() => throw UnimplementedError(),
          })
          // if (refreshEither.asL.maybeWhen(
          //   authFailure: (af) => af.maybeWhen(
          //     // clear tokens on token expired
          //     tokenExpired: () => true,
          //     orElse: () => false,
          //   ),
          //   orElse: () => false,
          // ))
          {
            await _authLocalDatasource.cacheTokens(null);
          }
          errorMessage = refreshEither.asL.message;
          return handler.reject(
            exception.copyWith(
              error: DioUnknownErrorEnum.sessionExpired,
              message: errorMessage,
            ),
          );
        }

        // save new [authTokens]
        final newTokens = refreshEither.asR;
        await _authLocalDatasource.cacheTokens(newTokens);

        // update the cached tokens value with new [authTokens]
        tokens = newTokens;
      }

      // append the [accessToken] to header
      options.headers = {'Authorization': 'Bearer ${tokens!.accessToken}'};
    }
    return handler.next(options);
  }
}
