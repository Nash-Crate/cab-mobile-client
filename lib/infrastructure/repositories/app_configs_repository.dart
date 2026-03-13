import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_client/infrastructure/datasources/datasources.dart';
import 'package:mobile_library/mobile_library.dart';

/// implementation of the IAppConfigsRepository
@Singleton(as: IAppConfigsRepository)
class AppConfigsRepository implements IAppConfigsRepository {
  /// Constructor
  const AppConfigsRepository(this._localDatasource);

  final AppConfigsLocalDatasource _localDatasource;

  @override
  Future<Either<Failure, bool>> getOnboardingViewed() {
    return _localDatasource.getOnboardingViewed();
  }

  @override
  Future<Either<Failure, Unit>> setOnboardingViewed() {
    return _localDatasource.setOnboardingViewed();
  }

  @override
  Future<Either<Failure, String?>> getDevicePhoneCode() {
    return _localDatasource.getDevicePhoneCode();
  }
}
