import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/logger.dart';
import 'package:mobile_library/mobile_library.dart';

/// Failures mapper
extension FailuresMapper on Failure {
  /// Get error message
  String get message {
    loggerNoStack.i(this);
    return switch (this) {
      // auth
      TokenExpired() => t.errors.failures.token.expired,
      NoPreviousAuth() => t.errors.failures.token.noPreviousAuth,
      // emailVerificationFailed: (_) => t.errors.authFailures.emailVerificationFailed,
      // passwordResetFailed: (_) => t.errors.authFailures.passwordResetFailed,
      ValidationFailed(:final error) => error,
      Failure() => t.errors.failures.somethingWentWrong,
    };
    // return map(
    //   authFailure: (af) => af.f.map(
    //     tokenExpired: (_) => t.errors.failures.token.expired,
    //     noPreviousAuth: (_) => t.errors.failures.token.noPreviousAuth,
    //     // emailVerificationFailed: (_) => t.errors.authFailures.emailVerificationFailed,
    //     // passwordResetFailed: (_) => t.errors.authFailures.passwordResetFailed,
    //     validationFailed: (f) => f.error,
    //   ),
    //   cacheFailure: (cf) => cf.f.map(
    //     cacheClearFailure: (f) => f.message ?? t.errors.failures.cache.clear,
    //     cacheSetFailure: (f) => f.message ?? t.errors.failures.cache.set,
    //     cacheGetFailure: (f) => f.message ?? t.errors.failures.cache.get,
    //   ),
    //   formatException: (fe) => fe.message,
    //   networkFailure: (nf) => nf.f.map(
    //     requestCancelled: (f) => t.errors.failures.somethingWentWrong,
    //     unauthorisedRequest: (f) => f.errorMessage ?? t.errors.failures.unauthorized,
    //     badRequest: (f) => t.errors.failures.somethingWentWrong,
    //     notFound: (f) => f.error.toString(),
    //     methodNotAllowed: (f) => t.errors.failures.somethingWentWrong,
    //     notAcceptable: (f) => t.errors.failures.somethingWentWrong,
    //     requestTimeout: (f) => t.errors.failures.somethingWentWrong,
    //     conflict: (f) => t.errors.failures.somethingWentWrong,
    //     internalServerError: (f) => t.errors.failures.somethingWentWrong,
    //     notImplemented: (f) => t.errors.failures.somethingWentWrong,
    //     serviceUnavailable: (f) => t.errors.failures.somethingWentWrong,
    //     connectionRefused: (f) => t.errors.failures.somethingWentWrong,
    //     noInternetConnection: (f) => t.errors.failures.somethingWentWrong,
    //     defaultError: (f) => f.error,
    //     unexpectedError: (f) => f.data.toString(),
    //     badCertificate: (f) => t.errors.failures.somethingWentWrong,
    //     badResponse: (f) => f.errorMessage ?? t.errors.failures.somethingWentWrong,
    //     connectionError: (f) => t.errors.failures.somethingWentWrong,
    //   ),
    //   unableToProcess: (uf) => uf.error,
    //   unexpectedError: (sf) => sf.message,
    // );
  }
}
