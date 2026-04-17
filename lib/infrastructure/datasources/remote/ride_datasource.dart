import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/infrastructure/infrastructure.dart';
import 'package:mobile_library/mobile_library.dart';

/// Datasource for fetching and managing ride data from a remote source.
abstract class RideRemoteDatasource with IRideRepository {}

/// Implementation of [RideRemoteDatasource] that fetches data from a remote source.
@Singleton(as: RideRemoteDatasource)
class RideRemoteDatasourceImplementation implements RideRemoteDatasource {
  /// constructor
  const RideRemoteDatasourceImplementation(this._polylinePoints);

  final PolylinePoints _polylinePoints;

  @override
  Future<Either<Failure, List<LatLong>>> getPolylineCoordinates(LatLong start, LatLong end) async {
    final polylineCoordinates = <LatLong>[];
    try {
      // Create Routes API request
      final request = RoutesApiRequest(
        origin: PointLatLng(start.latitude, start.longitude),
        destination: PointLatLng(end.latitude, end.longitude),
        // travelMode: TravelMode.driving,
        routingPreference: RoutingPreference.trafficAware,
      );

      // Get route using Routes API
      final response = await _polylinePoints.getRouteBetweenCoordinatesV2(request: request);

      if (response.routes.isEmpty) {
        return Left(
          Failure.unableToProcess(response.errorMessage ?? t.errors.location.noRouteFound),
        );
      }

      for (final route in response.routes) {
        // Access route information
        // ('Duration: ${route.durationMinutes} minutes');
        // ('Distance: ${route.distanceKm} km');

        // Get polyline points
        final points = route.polylinePoints ?? [];
        for (final point in points) {
          polylineCoordinates.add(LatLong(latitude: point.latitude, longitude: point.longitude));
        }
      }

      return Right(polylineCoordinates);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
