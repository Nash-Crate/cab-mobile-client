import 'package:flutter/material.dart';

/// 'Skeleton' for Trip history card
class TripHistoryCardSkeleton extends StatelessWidget {
  /// constructor
  const TripHistoryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
