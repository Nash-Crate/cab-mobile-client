import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_client/presentation/features/trip_history/trip_history.dart';
import 'package:mobile_library/mobile_library.dart';

/// Trip history details header
class TripDetailsHeader extends StatelessWidget {
  /// constructor
  const TripDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripHistoryDetailsCubit, TripHistoryDetailsState>(
      builder: (context, state) {
        return Column(
          children: [
            HSB(100.h),
            Center(
              child: Text(
                DateFormat('EEEE dd MMMM yyyy - HH:mm').format(state.trip.timestamp),
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: const Color.fromRGBO(3, 8, 6, 1),
                    fontSize: 52.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            HSB(80.h),
            Center(
              child: RichText(
                text: TextSpan(
                  text: state.trip.amount.toReal.toString(),
                  style: context.textTheme.displayLarge?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                  children: const [
                    // TextSpan(
                    //   text: '.${state.trip.amount.toFraction.toString().padLeft(2, '0')}',
                    //   style: context.textTheme.displayLarge?.copyWith(
                    //     color: context.colorScheme.primary.withOpacity(.5),
                    //     fontSize: 80.sp,
                    //   ),
                    // ),
                    TextSpan(text: ' MRU'),
                  ],
                ),
              ),
            ),
            HSB(80.h),
          ],
        );
      },
    );
  }
}
