import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_library/mobile_library.dart';

/// Usecase to get the polyline coordinates between two points
@singleton
class GetPolylineCoordinates implements Usecase<List<LatLong>, (LatLong, LatLong)> {
  /// constructor
  const GetPolylineCoordinates(this._repository);

  final IRideRepository _repository;

  @override
  Future<Either<Failure, List<LatLong>>> call((LatLong, LatLong) startEndPoints) {
    final (start, end) = startEndPoints;
    return _repository.getPolylineCoordinates(start, end);
  }
}
