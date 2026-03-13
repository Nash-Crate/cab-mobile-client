import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';

/// Trip history list
class TripHistoryList extends StatelessWidget {
  /// constructor
  const TripHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripHistoryCubit, TripHistoryState>(
      builder: (context, state) {
        return SliverList.builder(
          itemCount: state.trips.length + (state.processing ? 1 : 0),
          itemBuilder: (context, index) {
            if (state.processing && index == state.trips.length) {
              return const TripHistoryCardSkeleton();
            }

            final trip = state.trips[index];
            return TripHistoryCard(trip);
          },
        );
      },
    );
  }
}
