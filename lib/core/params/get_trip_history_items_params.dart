import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_library/mobile_library.dart';

part 'get_trip_history_items_params.freezed.dart';

/// Get trip history items params
@freezed
abstract class GetTripHistoryItemsParams with _$GetTripHistoryItemsParams {
  /// Constructor
  const factory GetTripHistoryItemsParams({
    @Default(TripHistorySortByEnum.latest) TripHistorySortByEnum sortBy,
    @Default(1) int page,
  }) = _GetTripHistoryItemsParams;
}
