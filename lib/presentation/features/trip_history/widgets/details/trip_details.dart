import 'package:flutter/material.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';

/// Trip details container
class TripDetails extends StatelessWidget {
  /// constructor
  const TripDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          TripDetailsHeader(),
          TripDetailsRoutes(),
          TripDetailsOptions(),
          TripDetailsDriver(),
        ],
      ),
    );
  }
}
