import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_client/infrastructure/infrastructure.dart';
import 'package:mobile_library/mobile_library.dart';

/// I18nRemoteDatasource interface
abstract class I18nLocalDatasource extends II18nRepository {}

/// I18nRemoteDatasource implementation
@Singleton(as: I18nLocalDatasource)
class I18nLocalDatasourceImpl implements I18nLocalDatasource {
  /// Constructor
  const I18nLocalDatasourceImpl(this._cacheStorage);

  final ICacheStorage _cacheStorage;

  @override
  Future<Either<Failure, Unit>> cacheLanguageCode(String langCode) async {
    try {
      await _cacheStorage.upsert<String>(
        key: CacheKeys.lastLocale.name,
        data: langCode,
      );
      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String?>> getCachedLanguageCode() async {
    try {
      final langCode =
          await _cacheStorage.read<String>(key: CacheKeys.lastLocale.name);
      return Right(langCode);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
