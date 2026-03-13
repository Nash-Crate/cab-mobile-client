import 'package:device_region/device_region.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_client/infrastructure/constants/cache_keys.dart';
import 'package:mobile_client/infrastructure/datasources/errors/errors.dart';
import 'package:mobile_client/infrastructure/storage/storage.dart';
import 'package:mobile_library/mobile_library.dart';
import 'package:phonecodes/phonecodes.dart';

/// AppConfigsLocalDatasource interface
abstract class AppConfigsLocalDatasource extends IAppConfigsRepository {}

/// AppConfigsLocalDatasource implementation
@Singleton(as: AppConfigsLocalDatasource)
class AppConfigsLocalDatasourceImpl implements AppConfigsLocalDatasource {
  /// Constructor
  const AppConfigsLocalDatasourceImpl(this._cacheStorage);

  final ICacheStorage _cacheStorage;

  @override
  Future<Either<Failure, Unit>> setOnboardingViewed() async {
    try {
      await _cacheStorage.upsert<bool>(
        key: CacheKeys.onboardingViewed.name,
        data: true,
      );
      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> getOnboardingViewed() async {
    try {
      final result =
          await _cacheStorage.read<bool>(key: CacheKeys.onboardingViewed.name);
      return Right(result ?? false);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String?>> getDevicePhoneCode() async {
    try {
      final cCode = await DeviceRegion.getSIMCountryCode();
      final result = Countries.findByCode(cCode?.toUpperCase() ?? 'US');

      return Right(result.dialCode);
    } on Exception {
      // return Left(InfraExceptions.exceptionToFailure(e));
      return const Right(null);
    }
  }
}
