import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_library/mobile_library.dart';

/// GoogleMap LatLng extensions
extension GoogleMapLatLngX on LatLng {
  /// convert google map [LatLng] to local [LatLong] entity
  LatLong get toLocalLatLong => LatLong(latitude: latitude, longitude: longitude);

  /// check if two [LatLng] are the same
  bool isSame(LatLng other) => latitude == other.latitude && longitude == other.longitude;
}

/// Local LatLong extensions
extension ApplicationLatLongX on LatLong {
  /// convert local [LatLong] to google map [LatLng]
  LatLng get toGMLatLng => LatLng(latitude, longitude);
}
