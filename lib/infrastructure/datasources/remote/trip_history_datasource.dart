import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/entities/entities.dart';
import 'package:mobile_client/core/params/params.dart';
import 'package:mobile_client/core/repositories/repositories.dart';
import 'package:mobile_library/mobile_library.dart';

/// TripHistoryRemoteDatasource interface
abstract class TripHistoryRemoteDatasource extends ITripHistoryRepository {}

/// TripHistoryRemoteDatasource implementation
@Singleton(as: TripHistoryRemoteDatasource)
class TripHistoryRemoteDatasourceImpl implements TripHistoryRemoteDatasource {
  @override
  Future<Either<Failure, ListResponse<Trip>>> getTripHistoryItems(
    GetTripHistoryItemsParams params,
  ) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (params.page == 2) {
      return const Right(
        ListResponse(
          page: 2,
          totalPages: 2,
          items: [
            // Trip(
            //   id: '01',
            //   amount: 250,
            //   timestamp: DateTime.now(),
            //   start: TripLocation(
            //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
            //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            //   ),
            //   end: TripLocation(
            //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
            //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            //   ),
            // ),
            // Trip(
            //   id: '02',
            //   amount: 300,
            //   timestamp: DateTime.now(),
            //   start: TripLocation(
            //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
            //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            //   ),
            //   end: TripLocation(
            //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
            //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            //   ),
            // ),
          ],
        ),
      );
    }
    return const Right(
      ListResponse(
        page: 1,
        totalPages: 2,
        items: [
          // Trip(
          //   id: '03',
          //   amount: 350,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
          // Trip(
          //   id: '04',
          //   amount: 400,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
          // Trip(
          //   id: '05',
          //   amount: 450,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
          // Trip(
          //   id: '06',
          //   amount: 500,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
          // Trip(
          //   id: '07',
          //   amount: 550,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
          // Trip(
          //   id: '08',
          //   amount: 600,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
          // Trip(
          //   id: '09',
          //   amount: 650,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
          // Trip(
          //   id: '10',
          //   amount: 700,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
          // Trip(
          //   id: '11',
          //   amount: 750,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
          // Trip(
          //   id: '12',
          //   amount: 800,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
          // Trip(
          //   id: '13',
          //   amount: 850,
          //   timestamp: DateTime.now(),
          //   start: TripLocation(
          //     locationName: '10 Lorem, ipsum adipiscing. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          //   ),
          //   end: TripLocation(
          //     locationName: '20 Lorem, ipsum dolor. Nouakchott',
          //     timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          //   ),
          // ),
        ],
      ),
    );
  }
}
