import 'package:fpdart/fpdart.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

/// Interface for trip history repository
// ignore: one_member_abstracts
abstract class ITripHistoryRepository {
  /// Get trip history items
  Future<Either<Failure, ListResponse<Trip>>> getTripHistoryItems(
    GetTripHistoryItemsParams params,
  );
}
