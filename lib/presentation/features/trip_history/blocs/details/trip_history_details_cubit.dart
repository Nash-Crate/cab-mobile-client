import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_client/core/core.dart';
import 'package:mobile_library/mobile_library.dart';

part 'trip_history_details_cubit.freezed.dart';
part 'trip_history_details_state.dart';

/// Trip history details cubit
@injectable
class TripHistoryDetailsCubit extends Cubit<TripHistoryDetailsState> {
  /// Constructor
  TripHistoryDetailsCubit(@factoryParam Trip trip)
      : super(TripHistoryDetailsState.initial(trip));

  /// Fetch trip history details
  Future<void> fetch() async {
    // TODO(fetch): Fetch trip details
    // final id = state.trip.id;
    emit(state.copyWith(error: null, processing: true));

    await Future<void>.delayed(const Duration(seconds: 1));

    emit(
      state.copyWith(
        processing: false,
        details: _details,
      ),
    );
  }
}

final _details = TripDetails(
  id: '001',
  timestamp: DateTime.now(),
  amount: 350,
  start: TripLocation(
    locationName: 'New York',
    timestamp: DateTime.now().subtract(const Duration(hours: 4)),
    latLong: const LatLong(
      latitude: 0,
      longitude: 0,
    ),
  ),
  end: TripLocation(
    locationName: 'London',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    latLong: const LatLong(
      latitude: 0,
      longitude: 0,
    ),
  ),
  payMethod: const PayMethod(
    id: '001',
    name: 'Cash',
  ),
  vehicleClass: const VehicleClass(
    id: '001',
    name: 'Standard Class',
  ),
  driver: const TripDriver(
    id: '001',
    name: 'John Doe',
    vehicle: Vehicle(
      id: '001',
      brand: 'Toyota',
      model: 'Corolla',
      color: 'Black',
      licensePlate: 'ABC-1234',
      imageUrl:
          'https://www.toyota.co.nz/globalassets/car-images/corolla-zxzr-nm1-218-20.png',
    ),
    imageUrl: 'https://randomuser.me/api/portraits/thumb/men/99.jpg',
    driverLocation: LatLong(latitude: 10, longitude: 10),
  ),
);
