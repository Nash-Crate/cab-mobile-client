import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_client/core/entities/entities.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/ride/ride.dart';
import 'package:mobile_library/mobile_library.dart';

/// Payment method option
class PaymentMethodOption extends StatefulWidget {
  /// constructor
  const PaymentMethodOption({super.key});

  @override
  State<PaymentMethodOption> createState() => _PaymentMethodOptionState();
}

class _PaymentMethodOptionState extends State<PaymentMethodOption> {
  int? _selected;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t.ride.options.payMethod.title,
                    style: context.textTheme.headlineMedium,
                  ),
                ],
              ),
              HSB(50.h),
              Row(
                children: [
                  SelectionCard(
                    selection: _selected == 0
                        ? SelectionState.selected
                        : SelectionState.notSelected,
                    onSelection: (value) {
                      // TODO(value): implement
                      setState(() => _selected = 0);
                    },
                    backgroundColor: const Color.fromRGBO(220, 255, 233, 1),
                    child: Column(
                      children: [
                        SizedBox(
                          width: .4.sw,
                          height: .2.sw,
                          child: AppImage(Assets.home.trip.payMethodCash.path),
                        ),
                        HSB(10.sp),
                        Text(
                          t.ride.options.payMethod.methods.cash,
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  WSB(50.w),
                  SelectionCard(
                    selection: _selected == 1
                        ? SelectionState.selected
                        : SelectionState.notSelected,
                    onSelection: (value) {
                      // TODO(value): implement
                      setState(() => _selected = 1);
                    },
                    backgroundColor: const Color.fromRGBO(220, 255, 233, 1),
                    child: Column(
                      children: [
                        SizedBox(
                          width: .4.sw,
                          height: .2.sw,
                          child: AppImage(Assets.home.trip.payMethodBankili.path),
                        ),
                        HSB(10.sp),
                        Text(
                          t.ride.options.payMethod.methods.bankili,
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  WSB(50.w),
                  SelectionCard(
                    selection: _selected == 2
                        ? SelectionState.selected
                        : SelectionState.notSelected,
                    onSelection: (value) {
                      // TODO(value): implement
                      setState(() => _selected = 2);
                    },
                    backgroundColor: const Color.fromRGBO(220, 255, 233, 1),
                    child: Column(
                      children: [
                        SizedBox(
                          width: .4.sw,
                          height: .2.sw,
                          child: AppImage(Assets.home.trip.payMethodSedad.path),
                        ),
                        HSB(10.sp),
                        Text(
                          t.ride.options.payMethod.methods.sedad,
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: _selected == null
                        ? null
                        : () {
                            // TODO(value): implement
                            context.read<RideCubit>().onPayMethodChanged(
                              const PayMethod(id: '1', name: 'Car'),
                            );
                            context.flow<TripStateEnum>().update(
                              (_) => TripStateEnum.preTripDetails,
                            );
                          },
                    child: Text(t.common.actions.cont),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
