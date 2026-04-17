import 'package:fpdart/fpdart.dart';
import 'package:mobile_library/mobile_library.dart';

/// Defines the contract for fetching and managing ride data.
mixin IRideRepository {
  /// Fetches the polyline coordinates between two points.
  Future<Either<Failure, List<LatLong>>> getPolylineCoordinates(LatLong start, LatLong end);
}
