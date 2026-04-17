import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/entities/entities.dart';
import 'package:mobile_client/core/params/params.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_client/infrastructure/datasources/datasources.dart';
import 'package:mobile_client/infrastructure/datasources/remote/ride_datasource.dart';
import 'package:mobile_library/mobile_library.dart';

/// implementation of the IRideRepository
@Singleton(as: IRideRepository)
class RideRepository implements IRideRepository {
  /// constructor
  const RideRepository(this._remoteDatasource);

  final RideRemoteDatasource _remoteDatasource;

  @override
  Future<Either<Failure, List<LatLong>>> getPolylineCoordinates(LatLong start, LatLong end) {
    return _remoteDatasource.getPolylineCoordinates(start, end);
  }
}
