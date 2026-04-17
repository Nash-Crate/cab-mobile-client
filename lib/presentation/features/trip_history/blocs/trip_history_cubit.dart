import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_client/presentation/extensions/extensions.dart';
import 'package:mobile_library/mobile_library.dart';

part 'trip_history_cubit.freezed.dart';

part 'trip_history_state.dart';

/// Trip history cubit
@injectable
class TripHistoryCubit extends Cubit<TripHistoryState> {
  /// Constructor
  TripHistoryCubit(this._getTripHistoryItems) : super(TripHistoryState.initial()) {
    unawaited(fetch());
  }

  final GetTripHistoryItems _getTripHistoryItems;

  /// Fetch trip history items according to the parameters
  /// use [reset] to re-fetch data from the first page
  /// use [refresh] to fetch data from the current page again
  Future<void> fetch({bool refresh = false, bool reset = false}) async {
    emit(
      state.copyWith(
        error: null,
        processing: true,
        trips: reset ? [] : state.trips,
      ),
    );

    final currentPage = reset ? 1 : state.page + (refresh ? 0 : 1);

    final params = GetTripHistoryItemsParams(
      sortBy: state.sortBy,
      page: currentPage,
    );
    final either = await _getTripHistoryItems(params);
    if (either.isLeft()) {
      return emit(state.copyWith(error: either.asL.message, processing: false));
    }

    final result = either.asR;
    emit(
      state.copyWith(
        trips: List.of(state.trips)..addAll(result.items),
        processing: false,
        page: currentPage,
        hasMore: result.totalPages > currentPage,
      ),
    );
  }

  /// Set trip history sort by and fetch again
  Future<void> setSortBy(TripHistorySortByEnum sortBy) async {
    emit(state.copyWith(sortBy: sortBy));
    await fetch(reset: true);
  }
}
