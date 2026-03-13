import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_library/mobile_library.dart';

/// Set onboarding viewed
@singleton
class GetOnboardingViewed implements UsecaseNoParams<bool> {
  /// Constructor
  const GetOnboardingViewed(this._repository);

  final IAppConfigsRepository _repository;

  @override
  Future<Either<Failure, bool>> call() {
    return _repository.getOnboardingViewed();
  }
}
