import 'package:fpdart/fpdart.dart';
import 'package:mobile_library/mobile_library.dart';

/// Interface for internationalization repository
abstract class II18nRepository {
  /// Get the cached language code from the device
  Future<Either<Failure, String?>> getCachedLanguageCode();

  /// Cache language code to the device
  Future<Either<Failure, Unit>> cacheLanguageCode(String langCode);
}
