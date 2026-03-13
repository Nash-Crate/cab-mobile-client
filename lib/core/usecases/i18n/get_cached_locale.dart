import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_library/mobile_library.dart';

/// Get the cached language code from the device
@singleton
class GetCachedLanguageCode implements UsecaseNoParams<String?> {
  /// Constructor
  const GetCachedLanguageCode(this._repository);

  final II18nRepository _repository;

  @override
  Future<Either<Failure, String?>> call() {
    return _repository.getCachedLanguageCode();
  }
}
