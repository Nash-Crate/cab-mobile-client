import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_client/core/entities/trip.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';
import 'package:mobile_client/presentation/routing/router.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip history card
class TripHistoryCard extends StatelessWidget {
  /// constructor
  const TripHistoryCard(this.trip, {super.key});

  /// Trip data
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 50.w),
      child: InkWell(
        onTap: () => context.push(
          TripHistoryDetailsPage.pushPath,
          extra: TripDetailsRouteExtra.fromTrip(trip),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 20,
                color: Colors.grey.withValues(alpha: .1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TripHistoryCardHeader(trip),
              TripHistoryCardBody(trip),
            ],
          ),
        ),
      ),
    );
  }
}
