import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_library/mobile_library.dart';

/// Cache language code to the device
@singleton
class GetDevicePhoneCode implements UsecaseNoParams<String?> {
  /// Constructor
  const GetDevicePhoneCode(this._repository);

  final IAppConfigsRepository _repository;

  @override
  Future<Either<Failure, String?>> call() {
    return _repository.getDevicePhoneCode();
  }
}
