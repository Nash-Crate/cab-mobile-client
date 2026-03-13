import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_client/infrastructure/datasources/datasources.dart';
import 'package:mobile_library/mobile_library.dart';

/// I18nRepository interface implementation
@Singleton(as: II18nRepository)
class I18nRepository implements II18nRepository {
  /// Constructor
  const I18nRepository(this._localDatasource);

  final I18nLocalDatasource _localDatasource;

  @override
  Future<Either<Failure, Unit>> cacheLanguageCode(String langCode) {
    return _localDatasource.cacheLanguageCode(langCode);
  }

  @override
  Future<Either<Failure, String?>> getCachedLanguageCode() {
    return _localDatasource.getCachedLanguageCode();
  }
}
