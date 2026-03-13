import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/entities/entities.dart';
import 'package:mobile_client/core/params/params.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_client/infrastructure/datasources/datasources.dart';
import 'package:mobile_library/mobile_library.dart';

/// implementation of the ITripHistoryRepository
@Singleton(as: ITripHistoryRepository)
class TripHistoryRepository implements ITripHistoryRepository {
  /// Constructor
  const TripHistoryRepository(this._remoteDatasource);

  final TripHistoryRemoteDatasource _remoteDatasource;

  @override
  Future<Either<Failure, ListResponse<Trip>>> getTripHistoryItems(
    GetTripHistoryItemsParams params,
  ) {
    return _remoteDatasource.getTripHistoryItems(params);
  }
}
