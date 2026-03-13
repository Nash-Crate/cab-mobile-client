part of '../router.dart';

/// A complex class.
class TripDetailsRouteExtra {
  /// Create a complex object.
  TripDetailsRouteExtra({
    required this.id,
    required this.tripType,
    required this.timestamp,
    required this.amount,
    required this.start,
    required this.end,
    required this.rideType,
    required this.ridePaymentMethod,
  });

  /// convert from [Trip] entity
  factory TripDetailsRouteExtra.fromTrip(Trip trip) {
    return TripDetailsRouteExtra(
      id: trip.id,
      tripType: trip.tripType,
      timestamp: trip.timestamp,
      amount: trip.amount,
      start: trip.start,
      end: trip.end,
      rideType: trip.rideType,
      ridePaymentMethod: trip.ridePaymentMethod,
    );
  }

  /// convert to [Trip] entity
  Trip toTrip() => Trip(
        id: id,
        tripType: TripTypeEnum.fixed,
        timestamp: timestamp,
        amount: amount,
        start: start,
        end: end,
        rideType: rideType,
        ridePaymentMethod: ridePaymentMethod,
      );

  /// The id.
  final String id;

  /// The trip type.
  final TripTypeEnum tripType;

  /// timestamp
  final DateTime timestamp;

  /// The amount.
  final double amount;

  /// Start location
  final TripLocation start;

  /// End location
  final TripLocation end;

  /// Ride type
  final RideType rideType;

  /// Payment method
  final RidePaymentMethod ridePaymentMethod;

  @override
  String toString() => '''
          TripDetailsRouteExtra(
            id: $id,
            tripType: $tripType, 
            timestamp: $timestamp,
            amount: $amount, 
            start: $start, 
            end: $end,
            rideType: $rideType,
            ridePaymentMethod: $ridePaymentMethod
          )
          ''';
}
