import 'package:flutter/material.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip history card header
class TripHistoryCardHeader extends StatelessWidget {
  /// constructor
  const TripHistoryCardHeader(this.trip, {super.key});

  /// Trip history item
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 40.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        color: const Color.fromRGBO(255, 249, 231, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TripHistoryCardTimestamp(trip.timestamp),
          TripHistoryCardAmount(trip.amount),
        ],
      ),
    );
  }
}
