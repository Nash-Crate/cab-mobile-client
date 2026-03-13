import 'package:fpdart/fpdart.dart';
import 'package:mobile_library/mobile_library.dart';

/// Interface for app configs repository
abstract class IAppConfigsRepository {
  /// Set onboarding viewed flag
  Future<Either<Failure, Unit>> setOnboardingViewed();

  /// Get onboarding viewed flag
  Future<Either<Failure, bool>> getOnboardingViewed();

  /// Get device phone code
  Future<Either<Failure, String?>> getDevicePhoneCode();
}
