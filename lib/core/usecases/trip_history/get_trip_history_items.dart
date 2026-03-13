import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

/// Get trip history items usecase
@singleton
class GetTripHistoryItems
    implements Usecase<ListResponse<Trip>, GetTripHistoryItemsParams> {
  /// Constructor
  const GetTripHistoryItems(this._repository);

  final ITripHistoryRepository _repository;

  @override
  Future<Either<Failure, ListResponse<Trip>>> call(
    GetTripHistoryItemsParams params,
  ) {
    return _repository.getTripHistoryItems(params);
  }
}
