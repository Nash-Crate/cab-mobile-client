import 'package:fpdart/fpdart.dart';
import 'package:mobile_client/core/entities/user.dart';
import 'package:mobile_client/core/usecases/usecases.dart';
import 'package:mobile_library/mobile_library.dart';

/// Interface for authentication repository
abstract class IAuthRepository {
  /// Send a login check otp
  ///
  /// returns 'true' if user exists
  Future<Either<Failure, bool>> requestLoginCheckOtp(
    FullPhoneNumber phoneNumber,
  );

  /// Send a rider login request to the server
  Future<Either<Failure, Unit>> riderLogin(LoginRiderParams params);

  /// Send a rider signup request to the server
  Future<Either<Failure, Unit>> riderSignUp(RiderSignUpParams params);

  /// Check if previous auth tokens exists
  Future<Either<Failure, bool>> checkAuth();

  /// Get the current user
  Future<Either<Failure, User>> getUser();

  /// Logout user from the app
  Future<Either<Failure, Unit>> logout();
}
