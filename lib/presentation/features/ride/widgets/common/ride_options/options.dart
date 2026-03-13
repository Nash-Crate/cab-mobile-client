import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';

/// Ride options
class RideOptions extends StatelessWidget {
  /// constructor
  const RideOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<TripStateEnum>(
      state: TripStateEnum.vehicleClassSelection,
      onGeneratePages: (tripState, pages) {
        return [
          if (tripState == TripStateEnum.vehicleClassSelection)
            const MaterialPage(child: VehicleClassOption())
          else if (tripState == TripStateEnum.paymentMethodSelection)
            const MaterialPage(child: PaymentMethodOption())
          else if (tripState == TripStateEnum.preTripDetails)
            const MaterialPage(child: PreTripDetails())
          else if (tripState == TripStateEnum.driverSearching)
            const MaterialPage(child: DriverSearching())
          else if (tripState == TripStateEnum.driverArriving)
            const MaterialPage(child: DriverArriving())
          else if (tripState == TripStateEnum.driverArrived)
            const MaterialPage(child: DriverArrived())
          else if (tripState == TripStateEnum.tripOnTheWay)
            const MaterialPage(child: TripOnTheWay())
          else if (tripState == TripStateEnum.tripCompleted)
            const MaterialPage(child: TripCompleted()),
        ];
      },
    );
  }
}
