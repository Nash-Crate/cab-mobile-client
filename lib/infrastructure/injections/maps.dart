import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:injectable/injectable.dart';

/// External library injection for maps
@module
abstract class MapsExternalLibraryInjectableModule {
  /// DI for SharedPreferences library
  @singleton
  PolylinePoints polylinePoints() => PolylinePoints(
    apiKey: const String.fromEnvironment('GOOGLE_MAPS_API_KEY_ENVIRONMENT_VARIABLE'),
  );
}
