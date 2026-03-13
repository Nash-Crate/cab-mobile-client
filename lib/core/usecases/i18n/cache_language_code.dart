import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_library/mobile_library.dart';

/// Cache language code to the device
@singleton
class CacheLanguageCode implements Usecase<Unit, String> {
  /// Constructor
  const CacheLanguageCode(this._repository);

  final II18nRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String langCode) {
    return _repository.cacheLanguageCode(langCode);
  }
}
